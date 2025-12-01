require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

 describe '購入情報の保存' do
   context '購入情報が保存できるとき' do
    it 'すべての項目が正しく存在すれば出品できる' do
     expect(@order_address).to be_valid
    end
   
    it 'building が空でも購入できる' do
     @order_address.building = ''
     expect(@order_address).to be_valid
    end
   end

   context '購入情報が保存できないとき' do
    it 'postal_code が空だと保存できない' do
     @order_address.postal_code = ''
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
   
    it 'postal_code が「3桁-4桁」でないと保存できない' do
     @order_address.postal_code = '1234567'
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Postal code is invalid")
    end

    it 'prefecture_id が 1 だと保存できない' do
     @order_address.prefecture_id = 1
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'city が空だと保存できない' do
     @order_address.city = ''
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'address が空だと保存できない' do
     @order_address.address = ''
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end

    it 'phone_number が空だと保存できない' do
     @order_address.phone_number = ''
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_number が 9桁以下だと保存できない' do
     @order_address.phone_number = '123456789'
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Phone number is invalid")
    end

    it 'phone_number が 12桁以上だと保存できない' do
     @order_address.phone_number = '123456789012'
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Phone number is invalid")
    end

    it 'phone_number にハイフンがあると保存できない' do
     @order_address.phone_number = '090-1234-5678'
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Phone number is invalid")
    end

    it 'token が空だと保存できない' do
     @order_address.token = ''
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'user_id が空だと保存できない' do
     @order_address.user_id = nil
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_id が空だと保存できない' do
     @order_address.item_id = nil
     @order_address.valid?
     expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
  end
 end
end
