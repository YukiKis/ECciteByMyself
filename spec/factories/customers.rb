FactoryBot.define do 
  factory :customer1, class: Customer do
    last_name { "岸" }
    first_name { "優" }
    last_name_kana { "きし" }
    first_name_kana { "ゆう" }
    email { "yuki@com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    postcode { "1111111" }
    address { "滋賀県" }
    tel { "01234567890" }
  end
  
    factory :customer2, class: Customer do
    last_name { "森" }
    first_name { "林" }
    last_name_kana { "もり" }
    first_name_kana { "りん" }
    email { "rin@com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    postcode { "2222222" }
    address { "大阪府" }
    tel { "01234567890" }
  end
  
    factory :customer3, class: Customer do
    last_name { "川" }
    first_name { "羽" }
    last_name_kana { "かわ" }
    first_name_kana { "はね" }
    email { "kawa@com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    postcode { "3333333" }
    address { "兵庫県" }
    tel { "01234567890" }
  end
end