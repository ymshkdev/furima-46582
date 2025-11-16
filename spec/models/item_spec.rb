require 'rails_helper'

RSpec.describe Item, type: :model do
 before do
  @item = FactoryBot.build(:item)
 end

describe '出品登録' do
 context '出品登録できるとき' do
   it 'すべての項目が存在すれば出品できる' do
    expect(@item).to be_valid
   end
 end

  context '出品登録できないとき' do
    it 'titleが空では登録できない' do
     @item.title = ''
     @item.valid?
     expect(@item.errors.full_messages).to include("Title can't be blank")
    end
    it 'descriptionが空では登録できない' do
     @item.description = ''
     @item.valid?
     expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'imageが添付されていないと登録できない' do
     @item.image = nil
     @item.valid?
     expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'category_idが1（未選択）だと登録できない' do
     @item.category_id = 1
     @item.valid?
     expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'condition_idが1だと登録できない' do
     @item.condition_id = 1
     @item.valid?
     expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it 'shipping_fee_burden_idが1だと登録できない' do
     @item.shipping_fee_burden_id = 1
     @item.valid?
     expect(@item.errors.full_messages).to include("Shipping fee burden can't be blank")
    end
    it 'prefecture_idが1だと登録できない' do
     @item.prefecture_id = 1
     @item.valid?
     expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'shipping_day_idが1だと登録できない' do
     @item.shipping_day_id = 1
     @item.valid?
     expect(@item.errors.full_messages).to include("Shipping day can't be blank")
    end
    it 'priceが空では登録できない' do
     @item.price = ''
     @item.valid?
     expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが半角数値でないと登録できない' do
     @item.price = '３００'
     @item.valid?
     expect(@item.errors.full_messages).to include("Price is not a number")
    end
    it 'priceが300未満では登録できない' do
     @item.price = 299
     @item.valid?
     expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it 'priceが9,999,999より大きいと登録できない' do
     @item.price = 10_000_000
     @item.valid?
     expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
   it 'userが紐付いていなければ登録できない' do
    @item.user = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("User must exist")
   end
  end
 end
end