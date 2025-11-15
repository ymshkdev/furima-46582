class Item < ApplicationRecord
   belongs_to :user
   has_one_attached :image

  # ActiveHashを使う場合のアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_burden
  belongs_to :prefecture
  belongs_to :shipping_day

  # バリデーション
  validates :title, :description, :image, presence: true
  validates :category_id, :condition_id, :shipping_fee_burden_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end
