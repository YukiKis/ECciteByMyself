require 'rails_helper'

RSpec.describe "Public::Orders", type: :system do
  describe "about order page" do
    let(:customer1){ create(:customer1) }
    let(:category1){ create(:category1) }
    let(:category2){ create(:category2) }
    let(:item1){ create(:item1, category: category1) }
    let(:item2){ create(:item2, category: category2) }
    before do
      visit new_customer_session_path
      fill_in "customer[email]", with: customer1.email
      fill_in "customer[password]", with: customer1.password
      click_button "ログイン"
      @cart_item1 = customer1.cart_items.create(item: item1, amount: 3)
      @cart_item2 = customer1.cart_items.create(item: item2, amount: 2)
    end
    context "on order-new page" do
      before do
        visit new_order_path
      end
      it "has '注文情報入力'" do
        expect(page).to have_content "注文情報入力"
      end
      it "has radio-button for how_to_pay" do
        expect(page).to have_content "支払方法"
        expect(page).to have_field "order[how_to_pay]", with: "クレジットカード"
        expect(page).to have_field "order[how_to_pay]", with: "銀行振込" 
      end
      it "has radio-button for where to deliver" do
        # expect(page).to have_content "お届け先"
        # expect(page).to have_
      end
      it "has button to order-log page" do
        expect(page).to have_button "確認画面へ進む"
      end
      it "succeeds to go to order-log" do
        choose "クレジットカード"
        choose "ご自身の住所"
        click_button "確認画面へ進む"
        expect(current_path).to eq orders_log_path
      end
    end
    context "on order-log page" do
      before do
        visit new_order_path
        choose "クレジットカード"
        choose "ご自身の住所"
        click_button "確認画面へ進む"
        @order = customer1.orders.new({
          deliver_postcode: customer1.postcode,
          deliver_address: customer1.address,
          deliver_name: customer1.full_name,
          how_to_pay: 0
        })
        @order.set_order_items(customer1)
        @order.set_total_price
      end
      it "has '注文情報確認'" do
        expect(page).to have_content "注文情報確認"
      end
      it "has table-heading for items" do
        expect(page).to have_content "商品名"
        expect(page).to have_content "単価(税込)"
        expect(page).to have_content "数量"
        expect(page).to have_content "小計"
        expect(page).to have_content "送料"
        expect(page).to have_content "商品合計"
        expect(page).to have_content "請求金額"
      end
      it "has info for order_items" do
        @order.order_items.each do |order_item|
          expect(page).to have_content order_item.item.name
          expect(page).to have_content order_item.price
          expect(page).to have_content order_item.amount
          expect(page).to have_content order_item.subtotal
        end
        expect(page).to have_content @order.deliver_fee
        expect(page).to have_content @order.total_price
        expect(page).to have_content @order.get_whole_total_price
      end
      it "has info for how_to_pay" do
        expect(page).to have_content "支払方法"
        expect(page).to have_content @order.how_to_pay
      end
      it "has info for where to deliver" do
        expect(page).to have_content "お届け先"
        expect(page).to have_content @order.deliver_postcode
        expect(page).to have_content @order.deliver_address
        expect(page).to have_content @order.deliver_name
      end
      it "has button '購入を確定する'" do
        expect(page).to have_button "購入を確定する"
      end
      it "succeeds to make a new order" do
        click_button "購入を確定する"
        expect(current_path).to eq orders_thanks_path
      end
    end

    context "on order-thanks page" do
      before do 
        visit orders_thanks_path
      end
      it "has 'ご購入ありがとうございました！" do
        expect(page).to have_content "ご購入ありがとうございました！"
      end
    end

    context "on order-index page" do
      before do 
        visit orders_path
      end
      it "has '注文履歴一覧'" do
        expect(page).to have_content "注文履歴一覧"
      end
      it "has table-heading for order info" do
        expect(page).to have_content "注文日"
        expect(page).to have_content "配送先"
        expect(page).to have_content "注文商品"
        expect(page).to have_content "支払金額"
        expect(page).to have_content "ステータス"
        expect(page).to have_content "注文詳細"
      end
      it "has info for order" do
        customer1.orders.each do |order|
          expect(page).to have_content order.created_at.strftime("%Y/%m/%d")
          expect(page).to have_content order.deliver_postcode
          expect(page).to have_content order.deliver_address
          expect(page).to haev_content order.deliver_name
          order.order_items.each do |order_item|
            expect(page).to have_content order_item.item.name
          end
          expect(page).to have_content order.total_price
          expect(page).to have_content order.status
          expect(page).to have_link "表示する", order_path(order)
        end
      end
    end
    context "on order-show page" do
      before do
        @order = customer1.orders.new({ 
          deliver_postcode: customer1.postcode,
          deliver_address: customer1.address,
          deliver_name: customer1.full_name,
          deliver_fee: 800,
          how_to_pay: 0
        })
        @order.set_order_items(customer1)
        @order.total_price = @order.set_total_price
        @order.save
        visit order_path(@order)
      end
      it "has '注文履歴詳細'" do
        expect(page).to have_content "注文履歴詳細"
      end
      it "has '注文情報'" do
        expect(page).to have_content "注文情報"
      end
      it "has date for order" do
        expect(page).to have_content "注文日"
        expect(page).to have_content @order.created_at.strftime("%Y/%m/%d")
      end
      it "has where to deliver" do
        expect(page).to have_content "配送先"
        expect(page).to have_content @order.deliver_postcode
        expect(page).to have_content @order.deliver_address
        expect(page).to have_content @order.deliver_name
      end
      it "has how_to_pay" do
        expect(page).to have_content "支払方法"
        expect(page).to have_content @order.how_to_pay
      end
      it "has order_sttus" do
        expect(page).to have_content "ステータス"
        expect(page).to have_content @order.status
      end
      it "has '請求情報'" do
        expect(page).to have_content "請求情報"
      end
      it "has total_price" do
        expect(page).to have_content "商品合計"
        expect(page).to have_content @order.total_price
      end
      it "has deliver_fee" do
        expect(page).to have_content "配送料"
        expect(page).to have_content @order.deliver_fee
      end
      it "has whole_total_price" do
        expect(page).to have_content "ご請求額"
        expect(page).to have_content @order.get_whole_total_price
      end
      it "has '注文内容'" do
        expect(page).to have_content "注文内容"
      end
      it "has table-heading for order_items" do
        expect(page).to have_content "商品"
        expect(page).to have_content "単価（税込）"
        expect(page).to have_content "個数"
        expect(page).to have_content "小計"
      end
      it "has order_item info" do
        @order.order_items.each do |order_item|
          expect(page).to have_content order_item.item.name
          expect(page).to have_content order_item.price
          expect(page).to have_content order_item.amount
          expect(page).to have_content order_item.subtotal
        end
      end
    end
  end
end
