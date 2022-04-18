require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '商品購入' do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
  end

    context '商品購入ができる時' do
      it 'postal_codeとshipping_areaとcityとstreetとphoneが存在すれば購入できる' do
        expect(@purchase_shipping).to be_valid
      end
      it '建物名が空でも購入できる' do
        @purchase_shipping.building = ''
        expect(@purchase_shipping).to be_valid
      end
    end
    context '商品購入ができない時' do
      it 'postal_codeが空では購入できない' do
        @purchase_shipping.postal_code = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は無効です。ハイフン(-)を含めて入力してください")
      end
      it 'post_codeが「3桁ハイフン4桁」の半角文字列でなければ購入できない' do
        @purchase_shipping.postal_code = '1234567'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("郵便番号は無効です。ハイフン(-)を含めて入力してください")
      end
      it 'shipping_areaが未選択項目（idの１）を選択すると購入できない' do
        @purchase_shipping.shipping_area_id = 1
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'cityが空では購入できない' do
        @purchase_shipping.city = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'streetが空では購入できない' do
        @purchase_shipping.street = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("市町村を入力してください")
      end
      it 'phoneが空では購入できない' do
        @purchase_shipping.phone = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("電話番号を入力してください", "電話番号は数値で入力してください", "電話番号は10文字以上で入力してください")
      end
      it "phoneに半角数字以外が含まれると購入できない" do
        @purchase_shipping.phone = 'eじ'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("電話番号は数値で入力してください", "電話番号は10文字以上で入力してください")
      end
      it 'phoneが9桁以下では購入できない' do
        @purchase_shipping.phone = '123456789'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("電話番号は10文字以上で入力してください")
      end
      it 'phoneが12桁以上では購入できない' do
        @purchase_shipping.phone =  '123456789123'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
      it "tokenが空では購入できない" do
        @purchase_shipping.token = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("トークンを入力してください")
      end
      it 'itemが紐付いていないと保存できない' do
        @purchase_shipping.item_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Itemを入力してください")
      end
      it 'userが紐付いていないと保存できない' do
        @purchase_shipping.user_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
