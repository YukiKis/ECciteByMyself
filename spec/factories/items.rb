FactoryBot.define do
  factory :item1, class: Item do
    category_id { 1 }
    name { "イチゴのケーキ" }
    image_id { "image" }
    description { "当店一押し" }
    price { 400 }
    is_active { true }
  end
  factory :item2, class: Item do
    category_id { 2 }
    name { "すこーん" }
    image_id { "image" }
    description { "お土産に" }
    price { 300 }
  end
  factory :item3, class: Item do
    category_id { 3 }
    name { "ぷりんぷりん" }
    image_id { "image" }
    description { "デザートに" }
    price { 200 }
  end
  factory :item4, class: Item do
    category_id { 4 }
    name { "あいすきゃんでぃ" }
    image_id { "image" }
    description { "夏に" }
    price { 100 }
  end
end
