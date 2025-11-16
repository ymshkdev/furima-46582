FactoryBot.define do
  factory :item do
    title                   {'テスト商品'}
    description             {'テスト用の商品説明'}
    image                   { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_image.png'), 'image/png') }
    category_id             { 2 }
    condition_id            { 2 }
    shipping_fee_burden_id  { 2 }
    prefecture_id           { 2 }
    shipping_day_id         { 2 }
    price                   { 1000 }
    association :user
  end
end