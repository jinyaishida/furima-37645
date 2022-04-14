class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_area_id, :city, :street, :building, :phone, :user_id, :item_id, :phone, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :street
    validates :phone, numericality: { only_integer: true }, length: { maximum: 11, minimum: 10 }
    validates :shipping_area_id,numericality: { other_than: 1, message: "can't be blank" }
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Shipping.create(postal_code: postal_code, shipping_area_id: shipping_area_id, city: city, street: street, building: building, phone: phone, purchase_id: purchase.id)
  end
end