class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :house_number, :building, :telephone, :item_id, :user_id
  
  validates :prefecture_id, numericality: { other_than: 1 }
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-]?\d{4}|\d{2}[-]\d{3}|\d{3}[-]\d{2}|\d{4}[-]\d{1})[-]\d{4}\z|\A0[5789]0[-]\d{4}[-]\d{4}\z/
  validates :telephone, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
  
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :house_number
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)

   Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, house_number: house_number, building: building, telephone: telephone, order_id: order.id)
  end
  
end