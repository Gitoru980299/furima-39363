class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    #フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入する
    #@purchase = Purchase.new
    @purchase_shipping = PurchaseShipping.new
    #ログインしているユーザーが出品者であれば、又は売れていればトップページに遷移する
    if current_user == @item.user || @item.purchase.present?
      redirect_to root_path
   end
  end

  def create
    @purchase_shipping = PurchaseShipping.new(purchase_params)
    if @purchase_shipping.valid?
       pay_item
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
    params.require(:purchase_shipping).permit(:post_code, :prefecture_id, :city_address, :street_address, :building_name, :telephone_number).merge(item_id: params[:item_id], token: params[:token], user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
