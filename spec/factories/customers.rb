FactoryBot.define do 
  factory :customer4, class: Customer do
    last_name { "岸" }
    first_name { "優" }
    last_name_kana { "キシ" }
    first_name_kana { "ユウ" }
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
    last_name_kana { "モリ" }
    first_name_kana { "リン" }
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
    last_name_kana { "カワ" }
    first_name_kana { "ハネ" }
    email { "kawa@com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    postcode { "3333333" }
    address { "兵庫県" }
    tel { "01234567890" }
  end

    factory :customer1, class: Customer do
      last_name { "市" }
      first_name { "那" }
      last_name_kana { "イチ" }
      first_name_kana { "ナ" }
      email { "ichi@com" }
      password { "testtest" }
      password_confirmation { "testtest" }
      postcode { "1111111" }
      address { "滋賀県" }
      tel { "01234567890"}
    end
end