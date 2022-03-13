class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :house_number, :building, :telephone, :item_id, :user_id, :token
  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'は無効です。 ハイフンを含んでください' }
    validates :city
    validates :house_number
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選んでください' }
    validates :telephone, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)

    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city,
                   house_number: house_number, building: building, telephone: telephone, order_id: order.id)
  end
end
