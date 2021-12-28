require 'rails_helper'

RSpec.describe User, type: :model do
  before do
   @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規入力' do
   context '新規登録できる場合' do
     it "nickname、email、last_name、first_name、read_name_last、read_name_first、birthday, passwordとpassword_confirmationが存在すれば登録できる" do
     expect(@user).to be_valid
     end
     it "passwordが6文字以上の半角英数字混合であれば登録できる" do
      @user.password = "000aaa"
      @user.password_confirmation = "000aaa"
      expect(@user).to be_valid
      end
      it "last_nameが全角文字であれば登録できる" do
        @user.last_name = "山田"
        expect(@user).to be_valid
      end
      it "first_nameが全角文字であれば登録できる" do
        @user.first_name = "太郎"
        expect(@user).to be_valid
      end
      it "read_name_lastが全角カナであれば登録できる" do
        @user.read_name_last = "ヤマダ"
        expect(@user).to be_valid
      end
      it "read_name_firstが全角カナであれば登録できる" do
        @user.read_name_first = "タロウ"
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "重複したemailが存在すれば登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email:@user.email)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00aaa"
        @user.password_confirmation = "00aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが英数字混合でなければ登録できない" do
        @user.password = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password") 
      end
    end
  end
end