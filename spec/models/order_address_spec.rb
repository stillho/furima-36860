require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '購入内容確認' do
    context '商品購入が成功する場合' do
      it '全ての数値が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品購入が成功しない場合' do
      it 'postcodeが空だと購入できない' do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は無効です。 ハイフンを含んでください")
      end
      it 'prefectureを選択していないと購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('都道府県を選んでください')
      end
      it 'cityが空だと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numberが空だと購入できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'telephoneが空だと購入できない' do
        @order_address.telephone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end
      it 'tokenが空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("トークンを入力してください")
      end
      it 'postcodeにハイフンがないと購入できない' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は無効です。 ハイフンを含んでください')
      end
      it 'postcodeが全角だと購入できない' do
        @order_address.postcode = '１２３４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は無効です。 ハイフンを含んでください')
      end
      it 'telephoneが9桁だと購入できない' do
        @order_address.telephone = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'telephoneが12桁だと購入できない' do
        @order_address.telephone = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'telephoneにハイフンがあると購入できない' do
        @order_address.telephone = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'telephoneが全角だと購入できない' do
        @order_address.telephone = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'userが紐ついていないと購入できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'itemが紐ついていないと購入できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("アイテムを入力してください")
      end
    end
  end
end
