FactoryBot.define do
  factory :purchase_shipping do
    postal_code        { '123-4567' }
    shipping_area_id   {2}
    city               {"出雲市"}
    street             { '1-1' }
    building           { 'じ1' }
    phone              { '08081111234' }
    token              { "tok_abcdefghijk00000000000000000" }
  end
end