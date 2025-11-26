FactoryBot.define do
  factory :order do
    user { association(:user) }
    item { association(:item) }
  end
end
