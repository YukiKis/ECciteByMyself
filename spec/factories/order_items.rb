FactoryBot.define do
  factory :order_item do
    item_id { 1 }
    order_id { 1 }
    price { 1 }
    amount { 1 }
    status { 1 }
  end
end
