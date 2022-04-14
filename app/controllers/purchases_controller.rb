class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchase_shipping = PurchaseShipping.new
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.purchase
      redirect_to root_path
    end
  end

  def new
    @purchase_shipping = PurchaseShipping.new
  end

  def create
    @item = Item.find(params[:item_id])
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

  def purchase_params
    params.require(:purchase_shipping).permit(:postal_code, :shipping_area_id, :city, :street, :building, :card_number, :card_cvc, :phone, :card_exp_month, :card_exp_year).merge(user_id:current_user.id, item_id:params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_61b69aa4e8a9a51bfb81b28f"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
  end


end
