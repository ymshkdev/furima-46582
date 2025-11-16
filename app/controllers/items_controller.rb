class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
  end

  def new
   @item = Item.new
   # フォーム用にActiveHashを呼び出す
   @categories = Category.all
   @conditions = Condition.all
   @shipping_fee_burdens = ShippingFeeBurden.all
   @prefectures = Prefecture.all
   @shipping_days = ShippingDay.all
  end

  def create
   @item = Item.new(item_params)
   if @item.save
    redirect_to root_path
   else
    # 保存に失敗した場合もActiveHashを呼び出す
    @categories = Category.all
    @conditions = Condition.all
    @shipping_fee_burdens = ShippingFeeBurden.all
    @prefectures = Prefecture.all
    @shipping_days = ShippingDay.all
    render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :title, :description, :category_id, :condition_id, 
      :shipping_fee_burden_id, :prefecture_id, :shipping_day_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
