class OrdersController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!
  
  def index
    @order_address = OrderAddress.new
    # 出品者は購入させない＆売却済みはアクセス不可
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end
  
end
