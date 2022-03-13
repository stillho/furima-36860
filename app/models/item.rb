class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :aim

  belongs_to :user
  has_one :order
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_price
    validates :item_info
  end

  validates :item_price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'は300円〜9,999,999円の範囲で設定してください' }
  validates :item_price, numericality: { only_integer: true, message: 'は半角数字で記入してください' }
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :item_status_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :cost_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :aim_id, numericality: { other_than: 1, message: 'を選択してください' }
end
