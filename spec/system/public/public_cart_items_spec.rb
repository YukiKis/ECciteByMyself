require 'rails_helper'

RSpec.describe "Public::CartItems", type: :system do
  describe "about cart_item page" do
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
    end
    context "on cart_item index page" do
      before do
        @cart_item1 = customer1.cart_items.create(item: item1, amount: 3)
        @cart_item2 = customer1.cart_items.create(item: item2, amount: 2)
        visit cart_items_path
      end
      it "has 'ショッピングカート" do
        expect(page).to have_content "ショッピングカート"
      end
      it "has button to delete all cart_items" do
        expect(page).to have_link "カートを空にする", href: cart_items_all_path
      end
      it "has table heading for cart_items" do
        expect(page).to have_content "商品名"
        expect(page).to have_content "単価(税込)"
        expect(page).to have_content "数量"
        expect(page).to have_content "小計"
      end
      it "has cart_item info" do
        customer1.cart_items.each do |cart_item|
          expect(page).to have_content cart_item.item.name
          expect(page).to have_content (cart_item.item.price * 1.1).floor
          expect(page).to have_content cart_item.amount
          expect(page).to have_content cart_item.amount * ((cart_item.item.price * 1.1).floor)
        end
      end
      it "has field to change the amount" do
        customer1.cart_items.each do |cart_item| 
          expect(page).to have_field "cart_item[amount]", with: cart_item.amount
        end
      end
      it "has button to delete A cart_item" do
        customer1.cart_items.each do |cart_item|
          expect(page).to have_link "削除する", href: cart_item_path(cart_item)
        end
      end
      it "has '合計金額'" do
        expect(page).to have_content "合計金額"
        expect(page).to have_content (@cart_item1.item.price * 1.1).floor * @cart_item1.amount + (@cart_item2.item.price * 1.1).floor * @cart_item2.amount
      end
      it "succeeds to change the amount" do
        fill_in "cart_item-1", with: 10
        click_button "cart_item-update-1"
        expect(current_path).to eq cart_items_path
        expect(page).to have_field "cart_item-1", with: 10
      end
      it "succeeds to delete A cart_item" do
        click_link "削除する", href: cart_item_path(@cart_item1)
        expect(page).to have_no_content @cart_item1.item.name
      end
      it "succeeds to delte ALL cart_items" do
        click_link "カートを空にする"
        expect(page).to have_no_content @cart_item1.item.name
        expect(page).to have_no_content @cart_item2.item.name
      end
      it "has button to go back to the item-index page" do
        expect(page).to have_link "買い物を続ける", href: items_path
      end
      it "has button to order-new page" do
        expect(page).to have_link "情報入力に進む", href: new_order_path
      end
    end
  end
end
