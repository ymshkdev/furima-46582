FactoryBot.define do
  factory :address do
    postal_code { "123-4567"}
    prefecture_id { 1 }
    city { "MyString" }
    address { "MyString" }
    building { "MyString" }
    phone_number { "09012345678"}
    order { association(:order) }
  end
end
