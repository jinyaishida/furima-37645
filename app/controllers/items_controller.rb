class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  def index
    @items = Item.all.order("created_at DESC")
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
  end


  private
  def item_params
    params.require(:item).permit(:title, :price, :text, :image, :description, :category_id, :shipping_date_id, :shipping_area_id, :shipping_method_id, :condition_id).merge(user_id: current_user.id)
  end
  
end
