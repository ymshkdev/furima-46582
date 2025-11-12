# テーブル設計

## users テーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | -----------               |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
has_many :items
has_many :comments
has_many :orders, foreign_key: :buyer_id

## items テーブル

| Column     | Type       | Options                        |
| ------     | ------     | -----------                    |
| name       | string     | null: false                    |
| img_url    | string     | null: false                    |
| user       | references | null: false, foreign_key: true |
| description| string     | null: false                    |
| price      | integer    | null: false                    |


### Association
belongs_to :user
has_many :comments
has_one :order

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :item

## orders テーブル

| Column  | Type       | Options                                          |
| ------- | ---------- | ------------------------------                   |
| buyer   | references | null: false, foreign_key: { to_table: :users }   |
| item    | references | null: false, foreign_key: true                   |
| status  | string     | default: "pending"                               |

### Association
belongs_to :buyer, class_name: "User"
belongs_to :item
has_one :address

## addresses テーブル

| Column       | Type       | Options                        |
| -------      | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| street       | string     | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association
belongs_to :order