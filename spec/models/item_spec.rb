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
        expect(@item.errors.full_messages).to include('画像を入力してください')
      end
      it 'item_nameが空だと出品できない' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it 'item_infoが空だと出品できない' do
        @item.item_info = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'categoryが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'item_statusが未選択だと出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'costが未選択だと出品できない' do
        @item.cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'prefectureが未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'aimが未選択だと出品できない' do
        @item.aim_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'item_priceが空だと出品できない' do
        @item.item_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格を入力してください')
      end
      it 'item_priceが全角数字だと出品できない' do
        @item.item_price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300円〜9,999,999円の範囲で設定してください', '販売価格は半角数字で記入してください')
      end
      it 'item_priceが設定範囲外だと出品できない(上限)' do
        @item.item_price = 10_000_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300円〜9,999,999円の範囲で設定してください')
      end
      it 'item_priceが設定範囲外だと出品できない(下限)' do
        @item.item_price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300円〜9,999,999円の範囲で設定してください')
      end
      it 'ユーザーが紐ついていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('ユーザーを入力してください')
      end
    end
  end
end
