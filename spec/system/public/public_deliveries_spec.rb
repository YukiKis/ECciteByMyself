require 'rails_helper'

RSpec.describe "Public::Deliveries", type: :system do
  describe "about delivery page" do
    let(:customer1){ create(:customer1) }
    let(:delivery1){ create(:delivery1, customer: customer1) }
    before do
      visit new_customer_session_path
      fill_in "customer[email]", with: customer1.email
      fill_in "customer[password]", with: customer1.password
      click_button "ログイン"
    end
    context "on delivery index page" do
      before do
        visit deliveries_path
      end 
      it "has '配送先登録/一覧'" do
        expect(page).to have_content "配送先登録/一覧"
      end
      it "has postcode field" do
        expect(page).to have_content "郵便番号(ハイフンなし)"
        expect(page).to have_field "delivery[postcode]"
      end
      it "has address field" do
        expect(page).to have_content "住所"
        expect(page).to have_field "delivery[address]"
      end
      it "has name field" do
        expect(page).to have_content "宛名"
        expect(page).to have_field "delivery[name]"
      end
      it "has button to add new delivery" do
        expect(page).to have_button "登録する"
      end
      it "succeeds to add new delivery" do
        fill_in "delivery[postcode]", with: "9999999"
        fill_in "delivery[address]", with: "北海道札幌市"
        fill_in "delivery[name]", with: "HKT"
        click_button "登録する"
        expect(current_path).to eq deliveries_path
        # expect(page).to have_content "9999999"
        # expect(page).to have_content "北海道札幌市"
        # expect(page).to have_content "HKT"
      end
      it "has table-heading for delivery info" do
        expect(page).to have_content "郵便番号"
        expect(page).to have_content "住所"
        expect(page).to have_content "宛名"
      end
      it "has delivery info" do
        fill_in "delivery[postcode]", with: "9999999"
        fill_in "delivery[address]", with: "北海道札幌市"
        fill_in "delivery[name]", with: "HKT"
        click_button "登録する"
        customer1.deliveries.each do |delivery|
          expect(page).to have_content delivery.postcode
          expect(page).to have_content delivery.address
          expect(page).to have_content delivery.name
          expect(page).to have_link "編集する", href: edit_delivery_path(delivery)
          expect(page).to have_link "削除する", href: delivery_path(delivery)
        end
      end
      it "succeeds to delete A delvery" do
        fill_in "delivery[postcode]", with: "9999999"
        fill_in "delivery[address]", with: "北海道札幌市"
        fill_in "delivery[name]", with: "HKT"
        click_button "登録する"
        delivery = customer1.deliveries.all.first
        click_link "削除する"
        expect(current_path).to eq deliveries_path
        expect(page).to have_no_content delivery.postcode
        expect(page).to have_no_content delivery.address
        expect(page).to have_no_content delivery.name
      end
    end
    context "on delivery edit page" do
      before do
        visit deliveries_path
        fill_in "delivery[postcode]", with: "9999999"
        fill_in "delivery[address]", with: "北海道札幌市"
        fill_in "delivery[name]", with: "HKT"
        click_button "登録する"
        @delivery = customer1.deliveries.all.first
        visit edit_delivery_path(@delivery)
      end
      it "has '配送先編集'" do
        expect(page).to have_content "配送先編集"
      end
      it "has postcode field" do
        expect(page).to have_content "郵便番号(ハイフンなし)"
        expect(page).to have_field "delivery[postcode]", with: @delivery.postcode
      end
      it "has address field" do
        expect(page).to have_content "住所"
        expect(page).to have_field "delivery[address]", with: @delivery.address
      end
      it "has name field" do
        expect(page).to have_content "宛名"
        expect(page).to have_field "delivery[name]", with: @delivery.name
      end
      it "has button to update" do
        expect(page).to have_button "編集する"
      end
      it "succeeds to edit" do
        fill_in "delivery[postcode]", with: "1010101"
        fill_in "delivery[address]", with: "滋賀県大津市"
        fill_in "delivery[name]", with: "BCC"
        click_button "編集する"
        expect(current_path).to eq deliveries_path
        expect(page).to have_content "1010101"
        expect(page).to have_content "滋賀県大津市"
        expect(page).to have_content "BCC"
      end
      it "fails to edit" do
        fill_in "delivery[postcode]", with: ""
        click_button "編集する"
        expect(page).to have_content "error"
      end
    end
  end
end
