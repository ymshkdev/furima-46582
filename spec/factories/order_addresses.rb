FactoryBot.define do
  factory :order_address do
    postal_code { "123-4567" }
    prefecture_id { 2 }
    city { "横浜市" }
    address { "1-1" }
    building { "ビル101" }
    phone_number { "09012345678" }
    token { "tok_abcdefghijk00000000000000000000" }

    user_id { create(:user).id }
    item_id { create(:item).id }
  end
end
