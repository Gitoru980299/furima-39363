class ItemsController < ApplicationController
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @items = Item.new
  end

  def create
    @items = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :category, :days_to_ship, :delivery_charge, :prefecture, :status, :item_name, :explanation, :price).merge(user_id: current_user.id)
  end
end
