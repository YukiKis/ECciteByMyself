FactoryBot.define do
  factory :order1, class: Order do
    deliver_postcode { "3333333" }
    deliver_address { "大阪府" }
    deliver_name { "友" }
    total_price { 1000 }
    deliver_fee { 800 }
    how_to_pay { 0 }
  end
end