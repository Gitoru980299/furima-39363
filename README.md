# README

##usersテーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| first_name         | string   | null: false               |
| first_name_kana    | string   | null: false               |
| last_name          | string   | null: false               |
| last_name_kana     | string   | null: false               |
| nickname           | string   | null: false               |
| birthday           | date     | null: false               |

###Association

* has_many :items
* has_many :purchased_items

##itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| item_name          | string     | null: false                    |
| explanation        | text       | null: false                    |
| delivery_charge_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| days_to_ship_id    | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

###Association

- has_one :purchased_item
- belongs_to :user


##purchased_itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |


###Association

- belongs_to :user
- belongs_to :item
- has_one : shipping_item


##shipping_itemsテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city_address       | string     | null: false                    |
| street_address     | string     | null: false                    |
| building_name      | string     |                                |
| telephone_number   | string     | null: false                    |
| purchased_item     | references | null: false, foreign_key: true |


###Association

- belongs_to :purchased_item