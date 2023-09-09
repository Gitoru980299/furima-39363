# README

##usersテーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| name               | string   | null: false               |
| nickname           | text     | null: false               |
| birthday           | text     | null: false               |

###Association

* has_many :items
* has_many :purchased_items

##itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| category           | string     | null: false                    |
| status             | string     | null: false                    |
| image              | text       | null: false                    |
| item_name          | text       | null: false                    |
| explanation        | text       | null: false                    |
| delivery_charge    | integer    | null: false                    |
| sender_area        | string     | null: false                    |
| days_to_ship       | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

###Association

- belongs_to :purchased_items
- belongs_to :users


##purchased_itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| image              | text       | null: false                    |
| item_name          | text       | null: false                    |
| delivery_charge    | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |


###Association

- belongs_to :users
- belongs_to :items
- has_one : shipping_items


##shipping_itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| address            | text       | null: false                    |
| post_code          | integer    | null: false                    |
| prefecture         | text       | null: false                    |
| city_address       | text       | null: false                    |
| street_address     | text       | null: false                    |
| building_name      | text       | null: false                    |
| telephone_number   | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |


###Association

- belongs_to :purchased_items