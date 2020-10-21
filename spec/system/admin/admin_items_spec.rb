require 'rails_helper'

RSpec.describe "Admin::Items", type: :system do
  describe "admin_items_page" do
    let(:admin1){ create(:admin1) }
    let!(:category1){ create(:category1) }
    let!(:category2){ create(:category2) }
    let!(:category3){ create(:category3) }
    let(:item1){ create(:item1, category: category1) }
    let(:item2){ create(:item2, category: category2) }
    let(:item3){ create(:item3, category: category3) }
    before do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin1.email
      fill_in "admin[password]", with: admin1.password
      click_button "ログイン"
    end
    context "on item_index page" do
      before do
        visit admin_items_path
      end
      it "has '商品一覧'" do
        expect(page).to have_content "商品一覧"
      end
      it "has heading for item info" do
        expect(page).to have_content "商品一覧"
        expect(page).to have_content "商品名"
        expect(page).to have_content "税抜価格"
        expect(page).to have_content "ジャンル"
        expect(page).to have_content "ステータス"
      end
      it "has items info" do
        Item.all.each do |item|
          expect(page).to have_content item.id
          expect(page).to have_link item.name, href: admin_item_path(item)
          expect(page).to have_content item.price
          expect(page).to have_content item.category.name
          expect(page).to have_content item.status
        end
      end
      it "has button to go to add_item_page" do
        expect(page).to have_link "", href: new_admin_item_path
      end
    end
    context "on new_item page" do
      before do
        visit new_admin_item_path
      end
      it "has '商品新規登録'" do
        expect(page).to have_content "商品新規登録"
      end
      it "has image for items" do
      end
      # it "has button to select image" do
      #   expect(page).to have_button "{}"
      # end
      it "has field for name" do
        expect(page).to have_content "商品名"
        expect(page).to have_field "item[name]"
      end
      it "has field for item description" do
        expect(page).to have_content "商品説明"
        expect(page).to have_field "item[description]"
      end
      it "has field for category" do
        expect(page).to have_content "ジャンル"
        expect(page).to have_field "item[category]"
      end
      it "has field for price" do
        expect(page).to have_content "税抜価格"
        expect(page).to have_field "item[price]"
      end
      it "has field for status" do
        expect(page).to have_content "販売ステータス"
        expect(page).to have_field "item[is_active]"
      end
      it "succeeds to make a new item" do
        # select item image
        fill_in "item[name]", with: "チョコケーキ"
        fill_in "item[description]", with: "新作です！"
        select "ケーキ", from: "item[category]"
        fill_in "item[price]", with: 750
        select "販売中", from: "item[is_active]"
        click_button "新規登録"
        expect(current_path).to eq admin_items_path
        expect(page).to have_content "チョコケーキ"
      end
      it "fails to add new item" do
        fill_in "item[name]", with: ""
        click_button "新規登録"
        expect(page).to have_content "error"
      end
    end
    context "on admin_item_show_page" do
      before do
        visit admin_item_path(item1)
      end
      it "has '商品詳細'" do
        expect(page).to have_content "商品詳細"
      end
      # it "has image for item" do
        
      # end
      it "has name for item" do
        expect(page).to have_content "商品名"
        expect(page).to have_content item1.name
      end
      it "has description for item" do
        expect(page).to have_content "商品説明"
        expect(page).to have_content item1.description
      end
      it "has category for item" do
        expect(page).to have_content "ジャンル"
        expect(page).to have_content "税込価格"
      end
      it "has price for item" do
        expect(page).to have_content "税込価格"
        expect(page).to have_content "（税抜価格）"
        expect(page).to have_content (item1.price * 1.1).floor
        expect(page).to have_content item1.price
      end
      it "has status for item" do
        expect(page).to have_content "販売ステータス"
        expect(page).to have_content item1.status
      end
      it "has button to edit" do
        expect(page).to have_link "編集する", href: edit_admin_item_path(item1)
      end
    end
    context "on edit_item page" do
      before do
        visit edit_admin_item_path(item1)
      end
      it "has '商品編集'" do
        expect(page).to have_content "商品編集"
      end
      it "has image for items" do
        #
      end
      # it "has button to select image" do
      #   expect(page).to have_button "{}"
      # end
      it "has field for name" do
        expect(page).to have_content "商品名"
        expect(page).to have_field "item[name]"
      end
      it "has field for item description" do
        expect(page).to have_content "商品説明"
        expect(page).to have_field "item[description]"
      end
      it "has field for category" do
        expect(page).to have_content "ジャンル"
        expect(page).to have_field "item[category]"
      end
      it "has field for price" do
        expect(page).to have_content "税抜価格"
        expect(page).to have_field "item[price]"
      end
      it "has field for status" do
        expect(page).to have_content "販売ステータス"
        expect(page).to have_field "item[is_active]"
      end
      it "succeeds to edit a item" do
        # select item image
        fill_in "item[name]", with: "バニラケーキ"
        fill_in "item[description]", with: "もう古いです！"
        select "ケーキ", from: "item[category]"
        fill_in "item[price]", with: 700
        select "販売中", from: "item[is_active]"
        click_button "変更を保存"
        expect(current_path).to eq admin_item_path(item1)
        expect(page).to have_content "バニラケーキ"
        expect(page).to have_content "もう古いです！"
        expect(page).to have_content "ケーキ"
        expect(page).to have_content "700"
        expect(page).to have_content "販売中"
      end
      it "fails to edit a item" do
        fill_in "item[name]", with: ""
        click_button "変更を保存"
        expect(page).to have_content "error"
      end
    end
  end
end
