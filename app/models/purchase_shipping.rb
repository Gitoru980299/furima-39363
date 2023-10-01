class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city_address, :street_address, :building_name, :telephone_number, :purchase_item, :item_id, :user_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city_address
    validates :street_address
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'must be 10 digits or 11 digits number' }
    #validates :token
    
  end
  
  def save
    # 購入情報を保存し、変数purchaseに代入する
    purchase = Purchase.create(user_id: user_id, item_id: item_id)

    # 住所を保存する
    # purchase_idには、変数purchaseのidと指定する
    Shipping.create(post_code: post_code, prefecture_id: prefecture_id, city_address: city_address, street_address: street_address, building_name: building_name, telephone_number: telephone_number, purchase_id: purchase.id)    
  end

end