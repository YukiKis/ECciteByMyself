
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create([{
  last_name: "岸",
  first_name: "優",
  last_name_kana: "きし",
  first_name_kana: "ゆう",
  postcode: "1111111",
  address: "滋賀",
  tel: "01234567890",
  email: "yuki@com",
  password: "testtest",
},
{
  last_name: "森",
  first_name: "林",
  last_name_kana: "もり",
  first_name_kana: "りん",
  postcode: "2222222",
  address: "大阪",
  tel: "01234567890",
  email: "rin@com",
  password: "testtest",
},
{
  last_name: "川",
  first_name: "羽",
  last_name_kana: "かわ",
  first_name_kana: "はね",
  postcode: "3333333",
  address: "兵庫",
  tel: "01234567890",
  email: "hane@com",
  password: "testtest",
}
])

Category.create([
  { name: "ケーキ" },
  { name: "焼き菓子"},
  { name: "プリン" },
  { name: "キャンディ"} 
])

Item.create([
  { category_id: 1, name: "イチゴケーキ", image_id: "Image", description: "いちおし！", price: 500 },
  { category_id: 2, name: "すこーん", image_id: "Image", description: "お土産に！", price: 400 },
  { category_id: 3, name: "プリンプリン", image_id: "Image", description: "デザートに", price: 300 }, 
  { category_id: 4, name: "アイスキャンディ", image_id: "Image", description: "夏の暑さに", price: 200 }
])

20.times do |n|
  Item.create({ category_id: 1, name: "ケーキ#{n}", image_id: "Image", description: "いちおし！", price: 300})
end

CartItem.create([
  { item_id: 1, customer_id: 1, amount: 3},
  { item_id: 2, customer_id: 1, amount: 2},
  { item_id: 2, customer_id: 2, amount: 4},
  { item_id: 3, customer_id: 2, amount: 1},
  { item_id: 3, customer_id: 3, amount: 4}, 
  { item_id: 4, customer_id: 3, amount: 2} 
])

Admin.create(
  { email: "yuki@com", password: "testtest" }
)

