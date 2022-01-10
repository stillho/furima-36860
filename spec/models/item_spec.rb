require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報入力' do
    context '商品情報入力が成功する場合' do
      it '全ての数値が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品情報入力が成功しない場合' do
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'item_nameが空だと出品できない' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'item_infoが空だと出品できない' do
        @item.item_info = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank")
      end
      it 'categoryが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'item_statusが未選択だと出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end
      it 'costが未選択だと出品できない' do
        @item.cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Cost can't be blank")
      end
      it 'prefectureが未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'aimが未選択だと出品できない' do
        @item.aim_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Aim can't be blank")
      end
      it 'item_priceが空だと出品できない' do
        @item.item_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price can't be blank")
      end
      it 'item_priceが全角数字だと出品できない' do
        @item.item_price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price Half-width number.')
      end
      it 'item_priceが設定範囲外だと出品できない(上限)' do
        @item.item_price = 10000000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price Out of setting range')
      end
      it 'item_priceが設定範囲外だと出品できない(下限)' do
        @item.item_price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Item price Out of setting range')
      end
      it 'ユーザーが紐ついていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
