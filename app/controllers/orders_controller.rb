class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_furima, only: [:index, :create]
  before_action :prevent_url, only: [:index, :create]

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

  def set_furima
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

  def prevent_url
    redirect_to root_path if @item.user_id == current_user.id || !@item.order.nil?
  end

  def address_params
    params.require(:order_address).permit(:postcode, :prefecture_id, :city, :house_number, :building, :telephone, :token).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end
end
