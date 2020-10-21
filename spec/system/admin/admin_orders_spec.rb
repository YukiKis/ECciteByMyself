require 'rails_helper'

RSpec.describe "Admin::Orders", type: :system do
  describe "about admin_order page" do
    let(:admin1){ create(:admin1) }
    let(:customer1){ create(:customer1) }
    let(:customer2){ create(:customer2) }
    let(:category1){ create(:category1) }
    let(:category2){ create(:category2) }
    let(:category3){ create(:category3) }
    let(:item1){ create(:item1, category: category1) }
    let(:item2){ create(:item2, category: category2) }
    let(:item3){ create(:item3, category: category3) }
    before do
      @cart_item1 = customer1.cart_items.create(item: item1, amount: 1)
      @cart_item2 = customer1.cart_items.create(item: item2, amount: 2)
      @cart_item3 = customer2.cart_items.create(item: item2, amount: 3) 
      @cart_item4 = customer2.cart_items.create(item: item3, amount: 4)

      @order1 = customer1.orders.new
      @order1.set_order_items(customer1)
      @order1.deliver_postcode = "1110000"
      @order1.deliver_address = "滋賀県"
      @order1.deliver_name = "母"
      @order1.deliver_fee = 800
      @order1.how_to_pay = 0
      @order1.total_price = @order1.set_total_price
      @order1.status = 0
      @order1.save
      
      @order2 = customer2.orders.new
      @order2.set_order_items(customer2)
      @order2.deliver_postcode = "2220000"
      @order2.deliver_address = "京都府"
      @order2.deliver_name = "祖母"
      @order2.deliver_fee = 800
      @order2.how_to_pay = 1
      @order2.total_price = @order2.set_total_price
      @order2.status = 0
      @order2.save
      
      visit new_admin_session_path
      fill_in "admin[email]", with: admin1.email
      fill_in "admin[password]", with: admin1.password
      click_button "ログイン"
    end
    context "on admin_order_index page" do
      before do
        visit admin_orders_path
      end
      it "has '注文履歴一覧'" do
        expect(page).to have_content "注文履歴一覧"
      end
      it "has table-header for order info" do
        expect(page).to have_content "購入日時"
        expect(page).to have_content "購入者"
        expect(page).to have_content "注文個数"
        expect(page).to have_content "注文ステータス"
      end
      it "has order info and link" do
        Order.all.each do |order|
          expect(page).to have_link order.created_at.strftime("%Y/%m/%d %H:%M:%S"), href: admin_order_path(order)
          expect(page).to have_content order.customer.last_name + order.customer.first_name
          expect(page).to have_content order.item_count
          expect(page).to have_content order.status
        end
      end
    end
    context "on admin_order_show page" do
      before do 
        visit admin_order_path(@order1)
      end
      it "has '注文履歴詳細'" do
        expect(page).to have_content "注文履歴詳細"
      end
      it "has header for order info" do
        expect(page).to have_content "購入者"
        expect(page).to have_content "配送先"
        expect(page).to have_content "支払方法"
        expect(page).to have_content "注文ステータス"
      end
      it "has info for order" do
      end
      it "has button for updating order status" do
        expect(page).to have_css "#update-order-status"
      end
      it "has table-heading for order_items" do
        expect(page).to have_content "商品名"
        expect(page).to have_content "単価（税込）"
        expect(page).to have_content "数量"
        expect(page).to have_content "小計"
        expect(page).to have_content "製作ステータス"
      end
      it "has info for order_items" do
        @order1.order_items.each do |order_item|
          expect(page).to have_content order_item.item.name
          expect(page).to have_content order_item.price
          expect(page).to have_content order_item.amount
          expect(page).to have_content order_item.subtotal
          expect(page).to have_content order_item.status
          expect(page).to have_css "#update-make-status-#{order_item.id}"
        end
      end
      it "has '商品合計'" do
        expect(page).to have_content "商品合計"
      end
      it "has total_price" do
        expect(page).to have_content @order1.total_price
      end
      it "has '送料'" do
        expect(page).to have_content "送料"
      end
      it "has deliver_fee" do
        expect(page).to have_content @order1.deliver_fee
      end
      it "has '請求金額合計'" do
        expect(page).to have_content @order1.get_whole_total_price
      end
      it "changes order_status" do
        select "発送済み", from: "order[status]"
        click_button "update-order-status"
        expect(current_path).to eq admin_order_path(@order1)
        expect(page).to have_select("order[status]", selected: "発送済み")
      end
      it "changes order_item_status" do
        select "製作中", from: "make-status-#{ @order1.id }"
        click_button "update-make-status-#{ @order1.id }"
        expect(current_path).to eq admin_order_path(@order1)
        expect(page).to have_select("make-status-#{ @order1.id}", selected: "製作中")
      end
    end
  end
end
