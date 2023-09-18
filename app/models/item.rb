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

 validates :item_name, presence: true
 validates :explanation, presence: true
 
 with_options presence: true, format: { with: /\A[0-9]+\z/ } do
   validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    presence: { message: "can't be blank" }
 end

 validates :image, presence: true

 has_one_attached :image
 
 #has_one :purchased_item
 belongs_to :user

end
