class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.order(created_at: :desc)
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
     redirect_to item_path(@item)
    else
     render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :title, :description, :category_id, :condition_id, 
      :shipping_fee_burden_id, :prefecture_id, :shipping_day_id, :price, :image
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_user
    unless @item.user_id == current_user.id
      redirect_to root_path, alert: "他人の商品は編集できません"
    end
  end

  
end
