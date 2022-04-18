class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  before_action :contributor_confirmation, only: [:edit, :update]


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
  end

  def edit
    if @item.purchase
      redirect_to action: :index
    unless current_user.id == @item.user_id 
      redirect_to action: :index
    end
   end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    unless current_user.id == @item.user_id
      redirect_to root_path
    else
      redirect_to action: :index
    end
      @item.destroy
  end


  private
  def item_params
    params.require(:item).permit(:title, :price, :text, :image, :description, :category_id, :shipping_date_id, :shipping_area_id, :shipping_method_id, :condition_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless @item.user == current_user
  end


end
  
