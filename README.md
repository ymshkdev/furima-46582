# テーブル設計

## users テーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | -----------               |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |


### Association
has_many :items
has_many :orders, foreign_key: :buyer_id

## items テーブル

| Column              | Type       | Options                        |
| ------              | ------     | -----------                    |
| name                | string     | null: false                    |
| user                | references | null: false, foreign_key: true |
| category            | string     | null: false                    |
| description         | text       | null: false                    |
| condition           | string     | null: false                    |
| status              | string     | default: "on_sale"             |
| price               | integer    | null: false                    |
| shipping_fee_burden | string     | null: false                    |
| prefecture          | string     | null: false                    |
| shipping_day        | string     | null: false                    |

### Association
belongs_to :user
has_one_attached :image
has_one :order


## orders テーブル

| Column  | Type       | Options                                          |
| ------- | ---------- | ------------------------------                   |
| buyer   | references | null: false, foreign_key: { to_table: :users }   |
| item    | references | null: false, foreign_key: true                   |

### Association
belongs_to :buyer, class_name: "User"
belongs_to :item
has_one :address

## addresses テーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture_id| integer    | null: false                    |
| city         | string     | null: false                    |
| street       | string     | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association
belongs_to :order