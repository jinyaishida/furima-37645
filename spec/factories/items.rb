FactoryBot.define do
  factory :item do
    title              {"じじ"}
    price              {500}
    shipping_method_id {2}
    category_id        {2}
    condition_id       {2}
    shipping_area_id   {2}
    description        {"ジジ"}
    shipping_date_id   {2}

    association :user
    
  end
end
    

