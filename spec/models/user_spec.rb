require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規入力' do
    context '新規登録できる場合' do
      it 'nickname、email、last_name、first_name、read_name_last、read_name_first、birthday, passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上の半角英数字混合であれば登録できる' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        expect(@user).to be_valid
      end
      it 'last_nameが全角文字であれば登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end
      it 'first_nameが全角文字であれば登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'read_name_lastが全角カナであれば登録できる' do
        @user.read_name_last = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'read_name_firstが全角カナであれば登録できる' do
        @user.read_name_first = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワードは半角英数字混合で設定してください', 'パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字を入力してください', '名字には全角文字を使用してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前を入力してください', '名前には全角文字を使用してください')
      end
      it 'read_name_lastが空では登録できない' do
        @user.read_name_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カタカナ）を入力してください', '名字（カタカナ）には全角カタカナを使用してください')
      end
      it 'read_name_firstが空では登録できない' do
        @user.read_name_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カタカナ）を入力してください', '名前（カタカナ）には全角カタカナを使用してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end

      it '重複したemailが存在すれば登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに@が含まれていない場合登録できない' do
        @user.email = 'hogehuga.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '00aaa'
        @user.password_confirmation = '00aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが半角英数字混合でなければ登録できない(数字のみ)' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で設定してください')
      end
      it 'passwordが半角英数字混合でなければ登録できない(英字のみ)' do
        @user.password = 'auhfou'
        @user.password_confirmation = 'auhfou'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で設定してください')
      end
      it 'passwordが半角でなければ登録できない' do
        @user.password = 'A B c 1 2 3'
        @user.password_confirmation = 'A B c 1 2 3'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で設定してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'last_nameが全角文字でなければ登録できない' do
        @user.last_name = 'hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字には全角文字を使用してください')
      end
      it 'first_nameが全角文字でなければ登録できない' do
        @user.first_name = 'huga'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前には全角文字を使用してください')
      end

      it 'read_name_lastが全角カタカナでなければ登録できない' do
        @user.read_name_last = 'あああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カタカナ）には全角カタカナを使用してください')
      end
      it 'read_name_firstが全角カタカナでなければ登録できない' do
        @user.read_name_first = 'いいいいい'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カタカナ）には全角カタカナを使用してください')
      end
    end
  end
end
