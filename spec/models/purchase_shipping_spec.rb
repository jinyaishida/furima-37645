require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '商品購入' do
  before do
    item = FactoryBot.create(:item)
    @purchase_shipping = FactoryBot.build(:purchase_shipping)
  end

    context '商品登録ができる時' do
      it 'postal_codeとshipping_areaとcityとstreetとphoneが存在すれば登録できる' do
        expect(@purchase_shipping).to be_valid
      end
    end
    context '商品購入ができない時' do
      it 'postal_codeが空では登録できない' do
        @purchase_shipping.postal_code = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'post_codeが「3桁ハイフン4桁」の半角文字列でなければ登録できない' do
        @purchase_shipping.postal_code = '1234567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'shipping_areaが未選択項目（idの１）を選択すると登録できない' do
        @purchase_shipping.shipping_area_id = 1
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Shipping area can't be blank")
      end
      it 'cityが空では登録できない' do
        @purchase_shipping.city = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'streetが空では登録できない' do
        @purchase_shipping.street = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Street can't be blank")
      end
      it 'phoneが空では登録できない' do
        @purchase_shipping.phone = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone can't be blank")
      end
      it "phoneに半角数字以外が含まれると登録できない" do
        @purchase_shipping.phone = 'eじ'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone is not a number")
      end
      it "tokenが空では登録できないこと" do
        @purchase_shipping.token = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
