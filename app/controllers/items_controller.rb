class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, except: [:index, :new, :create]
  #before_action :move_to_index, except: [:index]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    #ログインしているユーザーが出品者でなければ、又は売れていればトップページに遷移する
    if current_user != @item.user || @item.purchase.present?
       redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if current_user != @item.user
      redirect_to root_path
    else
      @item.destroy
      redirect_to root_path
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
  
  def item_params
    params.require(:item).permit(:image, :category_id, :days_to_ship_id, :delivery_charge_id, :prefecture_id, :status_id, :item_name, :explanation, :price).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   unless user_signed_in?
  #     redirect_to action: :index
  #   end
  # end
end
