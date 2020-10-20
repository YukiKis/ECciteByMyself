require 'rails_helper'

RSpec.describe "TestThroughs", type: :system do
  describe "test-through" do
    let(:admin1){ create(:admin1) }
    context "through" do
      it "through" do
        # マスタ登録
        
        # 1. メールアドレス・パスワードでログインする
        visit new_admin_session_path
        fill_in "admin[email]", with: admin1.email
        fill_in "admin[password]", with: admin1.password
        click_button "ログイン"
        
        # 2. ヘッダからジャンル一覧へのリンクを押下する
        click_link "ジャンル一覧", href: new_admin_categories_path
        expect(current_path).to eq new_admin_category_path

        # 3. 必要事項を入力し、登録ボタンを押下する
        fill_in "category[name]", with: "チョコレート"
        choose "有効"
        click_button "追加"
        expect(current_path).to eq new_admin_category_path
        expect(page).to have_content "チョコレート"
        
        # 4. ヘッダから商品一覧へのリンクを押下する
        click_link "商品一覧", href: admin_items_path
        expect(current_path).to eq admin_items_path
        
        # 5. 新規登録ボタンを押下する
        click_link "", href: admin_new_item_path
        expect(current_path).to eq admin_new_itme_path
        
        # 6. 商品新規登録画面
        # attach_file "チョコレート", ""
        fill_in "item[name]", with: "ちょこっとチョコレート"
        fil_in "item[description]", with: "小腹が空いたときに！"
        select "チョコレート", from: "item[cagetory]"
        fill_in "item[price]", with: 300
        select "販売中", from: item[is_active]
        click_button "新規登録"
        # expect(current_path).to eq admin_item_path
        expect(page).to have_content "ちょこっとチョコレート"
        
        # 7. ヘッダから商品一覧へのリンクを押下する
        click_link "商品一覧", href: admin_items_path
        
        # 8. -
        expect(current_path).to eq admin_items_path
        
        # 9. 新規登録ボタンを押下する(2商品目)
        click_link "", href: new_admin_item_path
        expect(current_path).to eq new_admin_item_path
        
        # 10. 必要事項を入力して登録ボタンを押下する
        fill_in "item[name]", with: "背筋も凍るアイスキャンディ"
        fil_in "item[description]", with: "うだるような暑さに"
        select "キャンディ", from: "item[cagetory]"
        fill_in "item[price]", with: 200
        select "販売中", from: item[is_active]
        # expect{ click_button "新規登録" }.to change(Item.all.count).by(1)
        # expect(current_path).to eq admin_item_path
        expect(page).to have_content "背筋も凍るアイスキャンディ"

        # 11. ヘッダから商品一覧へのリンクを押下する
        click_link "商品一覧", href: admin_items_path
        expect(current_path).to eq admin_items_path
        
        # 12. - 
        expect(page).to have_content "背筋も凍るアイスキャンディ"
        
        # 13. ヘッダからログアウトボタンをクリックする
        click_link "ログアウト", href: destroy_admin_session_path
        expect(current_path).to eq root_path
        
        # 登録～注文
        # 1. 新規登録画面へのリンクを押下する
        visit root_path
        click_link "新規登録", href: new_customer_registration_path
        expect(current_path).to eq new_customer_registratoin_path
        
        # 2. 必要事項を入力して登録ボタンを押下する
        fill_in "customer[last_name]", with: "市"
        fill_in "customer[first_name]", with: "那"
        fill_in "customer[last_name_kana]", with: "いち"
        fill_in "customer[first_name_kana]", with: "な"
        fill_in "customer[email]", with: "ichi@com"
        fill_in "customer[postcode]", with: "1111111"
        fill_in "customer[address]", with: "滋賀県"
        fill_in "customer[tel]", with: "01234567890"
        fill_in "customer[password]", with: "testtest"
        fill_in "customer[password_confirmation]", with: "testtest"
        click_button "新規登録"
        @customer1 = Customer.first
        # expect(current_path).to eq items_path 
        
        # 3. ヘッダがログイン用
        expect(page).to have_content "ようこそ、市 那様！"
        expect(page).to have_link "マイページ", href: customer_path
        expect(page).to have_link "商品一覧", href: items_path
        expect(page).to have_link "カート", href: cart_items_path
        expect(page).to have_link "ログアウト", href: destroy_customer_session_path
        
        # 4. 任意の商品画像を押下する
        @item1 = Item.all.first
        @item2 = Item.all.second
        expect(page).to have_content @item1.name
        expect(page).to have_content @item2.name
        click_link "", href: item_path(@item1)
        expect(current_path).to eq item_path(@item1)
        
        # 5. 商品情報が正しく表示されている
        expect(page).to have_content @item1.name
        expect(page).to have_content @item1.description
        expect(page).to have_content @item1.image
        expect(page).to have_button "カートに入れる"
        
        # 6. 個数を選択し、カートに入れるボタンを押下する
        select 1, from: "cart_item[amount]"
        click_button "カートに入れる"
        expect(current_path).to eq cart_items_path
        @cart_item1 = @customer.cart_items.find_by(item: @item1)
        
        # 7. カートの中身が正しく表示されている
        expect(page).to have_content @itm1.name
        expect(page).to have_content @item1.price * 1.1
        expect(page).to have_content @cart_item1.amount
        
        # 8. 買い物を続けるボタンを押下する
        click_link "買い物を続ける"
        expect(current_path).to eq items_path
        
        # 9. 任意の商品画像を押下する
        click_link "", href: item_path(@item2)
        expect(current_path).to eq item_path(@item2)
        
        # 10. 商品情報が正しく表示される
        expect(page).to have_content @item2.name
        expect(page).to have_content @item2.description
        expect(page).to have_content @item2.image
        expect(page).to have_button "カートに入れる"
        @cart_item2 = @customer1.cart_items.find_by(item: @item2)
        
        # 11. 個数を選択し、カートに入れるボタンを押下する
        select 2, from: "cart_item[amount]"
        click_button "カートに入れる"
        expect(current_path). to eq cart_items_path
        
        # 12. カートの中身が正しく表示される
        expect(page).to have_content @item2.name
        expect(page).to have_content @item2.price * 1.1
        expect(page).to have_content @cart_item2.amount
        
        # 13. 商品の個数を変更し、更新ボタンを押下する
        # fill_in "cart_item[amount]", with: "3"
        click_button "更新"
        expect(page).to have_content "3"
        expect(page).to have_content "990"

        # 14. 次に進むボタンを押下する
        click_button "情報入力に進む"
        expect(current_path).to eq new_order_path
        
        # 15. 支払方法を選択する
        choose "クレジットカード"
        expect(page).to have_checked_field "クレジットカード"
        
        # 16. 登録済みの自分の住所を選択する
        # choose
        # expect(page).to have_checked_field ""

        # 17. 次に進むボタンを押下する
        click_button "確認画面へ進む"
        expect(current_path).to eq orders_log_path
        @order1 = Order.first
        
        # 18. 選択した商品、合計金額、配送方法などが表示されている
        # 商品情報
        expect(page).to have_content @item1.name
        expect(page).to have_content @item1.price * 1.1
        expect(page).to have_content @cart_item1.amount
        expect(page).to have_content @cart_item1.subtotal
        expect(page).to have_content @item2.name
        expect(page).to have_content @item2.price * 1.1
        expect(page).to have_content @cart_item2.amount
        expect(page).to have_content @cart_item2.subtotal
        
        # 合計金額
        expect(page).to have_content @order1.deliver_fee
        expect(page).to have_content @order1.get_total_price
        expect(page).to have_content @order1.get_whole_total_price
        
        # 支払方法
        expect(page).to have_content @order1.how_to_pay
        
        # お届け先
        expect(page).to have_content @order1.deliver_postcode
        expect(page).to have_content @order1.deliver_address
        expect(page).to have_content @order1.deliver_name
        
        # 19. 確定ボタンを押下する
        click_button "購入を確定する"
        expect(current_path).to eq orders_thanks_path
        
        # 20. ヘッダのマイページへのリンクを押下する
        click_link "マイページ", href: customer_path
        expect(current_path).to eq customer_path(@customer1)
        
        # 21. 注文履歴一覧へのリンクを押下する
        click_link "一覧を見る", href: orders_path
        expect(current_path).to eq orders_path

        # 23. 先ほどの注文の詳細表示ボタンを押下する
        click_link "表示する", href: order_path(@order1)
        expect(current_path).to eq order_path(@order1)
        
        # 24. 注文の内容が正しく表示される
        expect(page).to have_content @order1.created_at.strftime("%Y/%m/%d")
        expect(page).to have_content @order1.deliver_postcode
        expect(page).to have_content @order1.deliver_address
        expect(page).to have_content @order1.deliver_name
        expect(page).to have_content @order1.how_to_pay
        expect(page).to have_content @order1.status
        
        expect(page).to have_content @order1.get_total_price
        expect(page).to have_content @order1.deliver_fee
        expect(page).to have_content @order1.get_whole_total_price
        
        @order1.order_items.each do |order_item|
          expect(page).to have_content order_item.item.name
          expect(page).to have_content order_item.price
          expect(page).to have_content order_item.amount
          expect(page).to have_content order_item.subtotal
        end
        
        # 24. ステータスが「入金待ち」になっている
        expect(page).to have_content "入金待ち"
        
        # 25. adminでログイン
        visit new_admin_session_path
        fill_in "admin[email]", with: admin1.email
        fill_in "admin[password]", with: admin1.password
        click_button "ログイン"
        expect(current_path).to eq admin_top_path
        
        # 26. ヘッダから注文履歴一覧へのリンクを押下する
        expect(page).to have_content "1件"
        click_link "注文履歴一覧"
        expect(current_path).to eq admin_orders_path
        
        # 27. 前テストでの注文の詳細表示ボタンを押下す
        expect(page).to have_link @order1.created_at.strftime("%Y/%m/%d %H:%M:%S"), href: admin_order_path(@order1)
        click_link @order1.created_at.strftime("%Y/%m/%d %H:%M:%S")
        expect(current_path).to eq admin_order_path(@order1)
        
        # 28. 注文ステータスを「入金確認」にする
        expect(page).to have_select "order[status]", selected: "入金待ち"
        
        # 29. 製作ステータスを1つ「製作中」にする @order_item.firstを指定する必要あり
        select "製作中", from: "order-item-1-status"
        expect(page).to have_select "order-item-1-status"
        
        # 30. 製作ステータスを全て「製作完了」にする
        select "製作完了", from: "order-item-1-status"
        expect(page).to have_select "order-item-1-status", selected: "製作完了" 
        select "製作完了", from: "order-item-2-status"
        expect(page).to have_select "order-item-2-status", selected: "製作完了"
        select "発送待ち", from: "order[staus]"
        expect(page).to have_select "order[status]", selected: "発送待ち"
        
        # 31. 注文ステータスを「発送済」にする
        select "発送済み", from: "order[status]"
        expect(page).to have_select "order[status]", selected: "発送済み"
        
        # 32. ヘッダからログアウトボタンを押下する
        click_link "ログアウト", href: "destroy_admin_session_path"
        expect(current_path).to eq root_path
        
        # 33. 注文した会員情報でログインをする
        visit new_customer_session_path
        fill_in "customer[email]", with: customer1.email
        fill_in "customer[password]", with: customer1.password
        click_button "ログイン"
        expect(current_path).to eq items_path
        
        # 34. ヘッダがログイン後の表示に代わっている
        expect(page).to have_link "マイページ", href: customer_path
        expect(page).to have_link "商品一覧", href: items_path
        expect(page).to have_link "カート", href: cart_items_path
        expect(page).to have_link "ログアウト", href: destroy_customer_session_path
        
        # 35. ヘッダからマイページに遷移する
        click_link "マイページ", href: customer_path
        expect(current_path).to eq custoemr_path
        
        # 36. 注文履歴一覧を表示するボタンを押下する
        click_link "一覧を見る", href: orders_path
        expect(current_path).to eq orders_path
        
        # 37. 注文履歴から先ほど注文した注文の詳細表示ボタンを押下する
        click_link "表示する", href: order_path(@order)
        expect(current_path).to eq order_path(@order)

        # 38. 注文のステータスが「発送済」になっている
        expect(page).to have_content "発送済み"
        
        # 39. 会員情報編集ボタンを押下する
        click_link "マイページ", href: customer_path
        click_link "編集する", href: edit_customer_path
        expect(current_path).to eq edit_customer_path
        
        # 40. 全項目を変更し、保存ボタンを押下する
        fill_in "customer[last_name]", with: "岸"
        fill_in "customer[first_name]", with: "夕"
        fill_in "customer[last_name_kana]", with: "きし"
        fill_in "customer[first_name_kana]", with: "ゆう"
        fill_in "customer[email]", with: "yuki@com"
        fill_in "customer[postcode]", "1110000"
        fill_in "customer[address]", with: "滋賀県大津市"
        fill_in "customer[tel]", with: "123123123"
        click_button "編集内容を保存する"
        expect(current_path).to eq customer_path

        # 41. 編集した内容が表示される
        expect(page).to have_content "岸"
        expect(page).to have_content "夕"
        expect(page).to have_content "きし"
        expect(page).to have_content "ゆう"
        expect(page).to have_content "yuki@com"
        expect(page).to have_content "1110000"
        expect(page).to have_content "滋賀県大津市"
        expect(page).to have_content "123123123"

        # 42.  配送先一覧表示ボタンを押下する
        click_link "一覧を見る", href: deliveries_path
        expect(current_path).to eq deliveries_path

        # 43. 各項目を入力し、登録ボタンを押下する
        fill_in "delivery[postcode]", with: "5050505"
        fill_in "delivery[address]", with: "沖縄県那覇市"
        fill_in "delivery[name]", with: "シーサー"
        click_button "登録する"
        @delivery1 = Delivery.first
        expect(current_path).to eq deliveries_path

        # 44. 登録した内容が表示されている
        expect(page).to have_content "5050505"
        expect(page).to have_content "沖縄県那覇市"
        expect(page).to have_content "シーサー"
        
        # 45. ヘッダからトップ画面へのリンクをクリックする
        # click_link "商品一覧", href: items_path
        # expect(current_path).to eq items_path
        
        # 46. 任意の商品画像を押下する
        click_link "", href: item_path(@item1)
        expect(current_path).to eq item_path(@item1)
        
        # 47. 商品情報が正しく表示されている
        expect(page).to have_content @item1.name
        expect(page).to have_content @item1.description
        expect(page).to have_content @item1.image
        
        # 48. 個数を選択し、カートに入れるボタンを押下する
        select 4, from: "cart_item[amount]"
        click_button "カートに入れる"
        @cart_item3 = @customer1.cart_items.create(item: @item1, amount: 4)
        expect(current_path).to eq cart_items_path
        
        # 49. カートの中身が正しく表示されている
        expect(page).to have_content @item1.name
        expect(page).to have_content @item1.price * 1.1
        expect(page).to have_field "cart_item[amount]", with: @cart_item3.amount
        expect(page).to have_content @cart_item3.subtotal
        
        # 50. 次に進むボタンを押下する
        click_button "情報入力に進む"
        expect(current_path).to eq new_order_path
        
        # 51. 先ほど登録した住所が選択できるようになっている
      # expect(page).to have_select("delivery", options: @delivery1)
        
        # 52. 任意の支払方法、登録した住所を選択し、購入ボタンを押下する
      # select @delivery1, from: "delivery"
        choose "銀行振込", from: "order[how_to_pay]"
        click_button "確認画面に進む"
        expect(current_path).to eq orders_log_path
        click_button "購入を確定する"
        expect(current_path).to eq orders_thanks_path
          
        # 53 ヘッダからトップ画面へのリンクをクリックする
        click_link "商品一覧", href: items_path
        expect(current_path).to eq items_path
        
        # 54. 任意の商品画像を押下する
        click_link "", href: item_path(@item1)
        expect(current_path).to eq item_path(@item1)
        
        # 55. 商品情報が正しく表示されている
        expect(page).to have_content @item1.name
        expect(page).to have_content @item1.description
        expect(page).to have_content @item1.image
        
        # 56. 個数を選択し、カートに入れるボタンを押下する
        select 5, from: "cart_item[amount]"
        click_button "カートに入れる"
        @cart_item4 = @customer4.cart_items.create(item: @item1, amount: 4)
        expect(current_path).to eq cart_items_path
        
        # 57. カートの中身が正しく表示されている
        expect(page).to have_content @item1.name
        expect(page).to have_content @item1.price * 1.1
        expect(page).to have_field "cart_item[amount]", with: @cart_item4.amount
        expect(page).to have_content @cart_item4.subtotal
        
        # 58. 次に進むボタンを押下する
        click_button "情報入力に進む"
        expect(current_path).to eq new_order_path
        
        # 59. 任意の支払方法を選択する
        choose "銀行振込", from: "order[how_to_pay]"

        # 60. 新規で住所を入力し、確定ボタンを押下する
        choose "新しいお届け先"
        fill_in "order[deliver_postcode]", with: "0987654"
        fill_in "order[deliver_address]", with: "大阪府難波"
        fill_in "order[deliver_name]", with: "DMMWC"
        click_button "確認画面へ進む"
        @order2 = Order.second
        
        # 61.選択した商品、合計金額、配送方法などが表示されている
        @order2.order_items.each do |order_item|
          expect(page).to have_content order_item.item.name
          expect(page).to have_content order_item.price
          expect(page).to have_content order_item.amount
          epxect(page).to have_content order_item.subtotal
        end
        
        expect(page).to have_content @order2.deliver_fee
        expect(page).to have_content @order2.get_total_price
        expect(page).to have_content @order2.get_whole_total_price
        
        expect(page).to have_content @order2.how_to_pay
        expect(page).to have_content @order2.deliver_postcode
        expect(page).to have_content @order2.deliver_address
        expect(page).to have_content @order2.deliver_name
      
        # 62. 確定ボタンを押下する
        click_button "購入を確定する"
        expect(current_path).to eq orders_thanks_path
        
        # 63.  ヘッダのマイページへのリンクを押下する
        click_link "マイページ", href: customer_path
        expect(current_path).to eq customer_path
        
        # 64. 配送先一覧へのリンクを押下する
        click_link "一覧を見る", href: deliveries_path
        expect(current_path).to eq deliveries_path
        
        # 65. 先ほど購入時に入力した住所が表示されている
        expect(page).to have_content "0987654"
        expect(page).to have_content "大阪府難波"
        expect(page).to have_content "DMMWC"
        
        # 66. マイページに戻る
        click_link "マイページ", href: customer_path
        expect(current_path).to eq customer_path
        
        # 67. 会員情報編集画面へのリンクを押下する
        click_link "編集する", href: edit_customer_path
        expect(current_path).to eq edit_customer_path
        
        # 68. 退会ボタンを押下する
        click_link "退会する", href: quit_path
        expect(current_path).to eq quit_path
        
        # 69. 退会ボタンを押下する
        click_button "退会する"
        expect(page.driver.browser.swtich_to.alert.text).to eq "本当に退会しますか？"
        
        # 70. 「はい」を押下する
        page.accept_confirm do
          click_button "退会する"
        end
        
        # 71. ヘッダが未ログイン状態になっている
        expect(current_path).to eq items_path
        expect(page).to have_link "About", href: about_path
        expect(page).to have_link "商品一覧", href: items_path
        expect(page).to have_link "新規登録", href: new_customer_registration_path
        expect(page).to have_link "ログイン", href: new_customer_session_path
        
        # 72. 退会したアカウントでログインを実施する
        click_link "ログイン", href: new_customer_session_path
        fill_in "customer[email]", with: @customer1.email
        fill_in "customer[password]", with: @customer1.password
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "error"
        
        # 73. adminでメールアドレス・パスワードでログインする
        visit new_admin_session_path
        fill_in "admin[email]", with: admin1.email
        fill_in "admin[password]", with: admin1.password
        click_button "ログイン"
        expect(current_path).to eq admin_top_path
        
        # 74. ヘッダから会員一覧画面へのリンクを押下する
        click_link "会員一覧", href: admin_customers_path
        expect(current_path).to eq admin_customers_path
        
        # 75. 先ほど退会したユーザが「退会済」になっている
        expect(page).to have_content @customer1.status
        
        # 76. 詳細表示ボタンを押下する
        click_link @customer1.full_name, href: admin_custeomr_path(@customer1)
        
        # 77. 変更した住所(ステータス)が表示されている
        expect(page).to have_content "退会会員"
 
        # 78. ヘッダからログアウトする
        click_link "ログアウト", href: destroy_admin_session_path
        expect(current_path).to eq new_admin_session_path
      end
    end
  end
end