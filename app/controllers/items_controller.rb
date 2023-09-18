class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  #before_action :move_to_index, except: [:index]

  def index
    #@items = Item.order("created_at DESC")
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

  private

  def item_params
    params.require(:item).permit(:image, :category_id, :days_to_ship_id, :delivery_charge_id, :prefecture_id, :status_id, :item_name, :explanation, :price).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   unless user_signed_in?
  #     redirect_to action: :index
  #   end
  # end
end
