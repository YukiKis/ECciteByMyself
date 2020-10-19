FactoryBot.define do
  factory :category1, class: Category do
    name { "ケーキ" }
  end
  factory :category2, class: Category do
    name { "焼き菓子" }
  end
  factory :category3, class: Category do
    name { "プリン" }
  end
  factory :category4, class: Category do
    name { "キャンディ" }
  end
end