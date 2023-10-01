class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    #フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入する
    #@purchase = Purchase.new
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
       #pay_item
       @purchase_shipping.save
       redirect_to root_path
    else    
      render :index
    end
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase_shipping).permit(:post_code, :prefecture_id, :city_address, :street_address, :building_name, :telephone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end
