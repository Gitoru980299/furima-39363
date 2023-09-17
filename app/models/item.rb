class Item < ApplicationRecord
 extend ActiveHash::Associations::ActiveRecordExtensions
 belongs_to :category
 belongs_to :days_to_ship
 belongs_to :delivery_charge
 belongs_to :prefecture
 belongs_to :status 

 validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
 validates :status_id, numericality: { other_than: 1 , message: "can't be blank"}
 validates :delivery_charge_id, numericality: { other_than: 1 , message: "can't be blank"}
 validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
 validates :days_to_ship_id, numericality: { other_than: 1 , message: "can't be blank"}

 validates :item_name, :string, presence: true
 validates :explanation, :text, presence: true
 validates :price, :integer, presence: true

 has_one_attached :image
 
 #has_one :purchased_item
 belongs_to :user

end
