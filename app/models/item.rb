class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category 
  belongs_to :item_status
  belongs_to :cost                  
  belongs_to :prefecture                  
  belongs_to :aim 

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_price 
    validates :category_id 
    validates :item_status_id
    validates :cost_id
    validates :prefecture_id 
    validates :item_info
    validates :aim_id 
  end

  validates :item_price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}
  validates :item_price, numericality: { only_integer: true, message: "Half-width number." }
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :cost_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :aim_id, numericality: { other_than: 1 , message: "can't be blank"}
end
