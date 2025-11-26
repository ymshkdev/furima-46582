class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  
  def index
    @order_address = OrderAddress.new
    # 出品者は購入させない＆売却済みはアクセス不可
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end
  
  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token
    ).merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
