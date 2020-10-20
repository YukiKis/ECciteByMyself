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
        expect(page).to have_content "(全" + Item.all.count + "件)"
      end
      it "has items" do
        Item.all.each do |item|
          # expect(page).to have image
          expect(page).to have_content item.name
          expect(page).to have_content item.price
        end
      end
      it "has categoried" do
        # expect(page).to have_link category1.name, href: ""
        # expect(page).to have_link category2.name, href: ""
        # expect(page).to have_link category3.name, href: ""
        # expect(page).to have_link category4.name, href: ""
      end
    end
    context "on item_show_page" do
      before do
        visit new_user_session_path
        fill_in "customer[email]", with: customer1.email
        fill_in "customer[password]", with: customer1.password
        click_button "ログイン"
        visit item_path(item1)
      end
      it "has categoried" do
        # expect(page).to have_link category1.name, href: ""
        # expect(page).to have_link category2.name, href: ""
        # expect(page).to have_link category3.name, href: ""
        # expect(page).to have_link category4.name, href: ""
      end
      it "has image for an item" do
        # expect(page).to have_ image
      end
      it "has item name" do
        expect(page).to have_content item1.name
      end
      it "leads to item-show page when clicking image" do
        Items.all.each do |item|
          expect(page).to have_link "", href: item_path(item)
        end
        click_link "", href: item_path(item1)
        expect(current_path).to eq item_path(item1)
      end
      it "has description" do
        expect(page).to have_content item1.description
      end
      it "has price" do
        expect(page).to have_content item1.price
      end
      it "has field to choose amount" do
        expect(page).to have_field "item[amount]"
      end
      it "has button to cart" do
        expect(page).to have_button "カートに入れる"
      end
      it "puts some items in a cart" do
        select 2, from: "item[amount]"
        click_button "カートに入れる"
        expect(current_path).to eq cart_items_path
        expect(page).to have_content item1.name
      end
    end
  end
end
