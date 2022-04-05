class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  #def index
    #@item = Item.all
  #end

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
    params.require(:item).permit(:title, :price, :text, :image, :description, :category_id, :shipping_date_id, :shipping_area_id, :shipping_method_id, :condition_id).merge(user_id: current_user.id)
  end
  
end
