FactoryBot.define do
  factory :admin1, class: Admin do
    email { "rin@com" }
    password { "testtest" }
    password_confirmation { "testtest" }
  end
end