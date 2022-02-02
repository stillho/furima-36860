class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.item_price,
      card: address_params[:token],
      currency: 'jpy'
    )
  end

  def address_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :house_number, :building, :telephone, :token).merge(
      user_id: current_user.id, item_id: @item, token: params[:token]
    )
  end
end
