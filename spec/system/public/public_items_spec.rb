require 'rails_helper'

RSpec.describe "Public::Items", type: :system do
  describe "customer items page" do
    let(:customer1){ create(:customer1) }
    let(:category1){ create(:category1) }
    let(:category2){ create(:category2) }
    let(:category3){ create(:category3) }
    let(:category4){ create(:category4) }
    let(:item1){ create(:item1, category: category1) }
    let(:item2){ create(:item2, category: category2) }
    let(:item3){ create(:item3, category: category3) }
    let(:item4) {create(:item4, category: category4) }
    context "on items_index page" do
      before do
        visit items_path
      end
      it "has '商品一覧'" do
        expect(page).to have_content "商品一覧"
      end
      it "has '全〇件'" do
        expect(page).to have_content "(全" + Item.all.count.to_s + "件)"
      end
      it "has items" do
        Item.all.each do |item|
          # expect(page).to have_link "item-image-#{item.id}", href: item_path(item)
          expect(page).to have_content item.name
          expect(page).to have_content item.price
        end
      end
      it "has categories" do
        Category.all.each do |category|
          expect(page).to have_link category.name, href: search_path(category)
        end
      end
      it "leads to item-show page when clicking image" do
        # Item.all.each do |item|
        #   expect(page).to have_link "item-image-#{item.id}", href: item_path(item)
        # end
        # click_link "item-image-#{item.id}", href: item_path(item1)
        # expect(current_path).to eq item_path(item1)
      end
    end
    context "on item_show_page" do
      before do
        visit new_customer_session_path
        fill_in "customer[email]", with: customer1.email
        fill_in "customer[password]", with: customer1.password
        click_button "ログイン"
        visit item_path(item1)
      end
      it "has categories" do
        Category.all.each do |category|
          expect(page).to have_link category.name, href: search_path(category)
        end
      end
      # it "has image for an item" do
      #   expect(page).to have_content "item-image-#{ item1.id }"
      # end
      it "has item name" do
        expect(page).to have_content item1.name
      end
      it "has description" do
        expect(page).to have_content item1.description
      end
      it "has price" do
        expect(page).to have_content (item1.price * 1.1).floor
      end
      it "has field to choose amount" do
        expect(page).to have_field "cart_item[amount]"
      end
      it "has button to cart" do
        expect(page).to have_button "カートに入れる"
      end
      it "puts some items in a cart" do
        select 2, from: "cart_item[amount]"
        click_button "カートに入れる"
        expect(current_path).to eq cart_items_path
        expect(page).to have_content item1.name
      end
    end
  end
end
