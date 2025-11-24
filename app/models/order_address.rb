class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token, :user_id, :item_id

  # バリデーションの処理
  with_options presence: true do
    validates :postal_code
    validates :city
    validates :address
    validates :phone_number
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
   # 購入情報（orders テーブル）を保存
    order = Order.create(
    user_id: user_id,
    item_id: item_id
    )
  # 配送先情報（addresses テーブル）を保存
    Address.create(
    postal_code: postal_code,
    prefecture_id: prefecture_id,
    city: city,
    address: address,
    building: building,
    phone_number: phone_number,
    order_id: order.id
    )
  end
end