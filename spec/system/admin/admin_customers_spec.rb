require 'rails_helper'

RSpec.describe "Admin::Customers", type: :system do
  describe "about admin_customer page" do
    let(:customer1){ create(:customer1) }
    let(:admin1){ create(:admin1) }
    before do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin1.email
      fill_in "admin[password]", with: admin1.password
      click_button "ログイン"
    end
    context "on admin_customer_index page" do
      before do
        visit admin_customers_path
      end
      it "has '会員一覧'" do
        expect(page).to have_content "会員一覧"
      end
      it "has table-header" do
        expect(page).to have_content "会員ID"
        expect(page).to have_content "氏名"
        expect(page).to have_content "メールアドレス"
        expect(page).to have_content "ステータス"
      end
      it "has customers info" do
        Customer.all.each do |customer|
          expect(page).to have_content customer1.id
          expect(page).to have_link customer1.full_name, href: admin_customer_path(customer1)
          expect(page).to have_content customer1.email
          expect(page).to have_content customer1.status
        end
      end
    end
    context "on admin_customer_show page" do
      before do
        visit admin_customer_path(customer1)
      end
      it "has '〇〇さんの会員詳細" do
        expect(page).to have_content customer1.last_name + customer1.first_name + "さんの会員詳細"
      end
      it "has heading for customer information" do
        expect(page).to have_content "顧客ID"
        expect(page).to have_content "氏名"
        expect(page).to have_content "フリガナ"
        expect(page).to have_content "郵便番号"
        expect(page).to have_content "住所"
        expect(page).to have_content "電話番号"
        expect(page).to have_content "メールアドレス"
      end
      it "has customer-information for each heading" do
        expect(page).to have_content customer1.id
        expect(page).to have_content customer1.full_name_with_space
        expect(page).to have_content customer1.full_name_kana_with_space
        expect(page).to have_content customer1.postcode
        expect(page).to have_content customer1.address
        expect(page).to have_content customer1.tel
        expect(page).to have_content customer1.email
      end
      it "has button for editing" do
        expect(page).to have_link "編集する", href: edit_admin_customer_path(customer1)
      end
      it "has button for checking orders" do
        expect(page).to have_link "注文履歴一覧を見る", href: admin_orders_path
      end
    end
    context "on admin_customer_edit page" do
      before do
        visit edit_admin_customer_path(customer1)
      end
      it "has '〇〇さんの会員情報編集'" do
        expect(page).to have_content customer1.last_name + customer1.first_name + "さんの会員情報編集"
      end
      it "has headings for customer info" do
        expect(page).to have_content "会員ID"
        expect(page).to have_content "氏名"
        expect(page).to have_content "フリガナ"
        expect(page).to have_content "郵便番号"
        expect(page).to have_content "住所"
        expect(page).to have_content "電話番号"
        expect(page).to have_content "メールアドレス"
        expect(page).to have_content "会員ステータス"
      end
      it "has forms to update" do
        expect(page).to have_content customer1.id
        expect(page).to have_field "customer[first_name]"
        expect(page).to have_field "customer[last_name]"
        expect(page).to have_field "customer[first_name_kana]"
        expect(page).to have_field "customer[last_name_kana]"
        expect(page).to have_field "customer[postcode]"
        expect(page).to have_field "customer[address]"
        expect(page).to have_field "customer[tel]"
        expect(page).to have_field "customer[email]"
        expect(page).to have_css "#customer_is_active_true"
        expect(page).to have_css "#customer_is_active_false"
      end
      it "has button to update customer_info" do
        expect(page).to have_button "変更を保存する"
      end
      it "updates customer information" do
        fill_in "customer[last_name]", with: "峰"
        fill_in "customer[first_name]", with: "夕"
        fill_in "customer[last_name_kana]", with: "みね"
        fill_in "customer[first_name_kana]", with: "ゆう"
        fill_in "customer[postcode]", with: "0009999"
        fill_in "customer[address]", with: "沖縄県那覇市"
        fill_in "customer[tel]", with: "99999999999"
        fill_in "customer[email]", with: "mine@com"
        choose "退会済み"
        click_button "変更を保存する"
        expect(current_path).to eq admin_customer_path(customer1)
        expect(page).to have_content "峰"
        expect(page).to have_content "夕"
        expect(page).to have_content "みね"
        expect(page).to have_content "ゆう"
        expect(page).to have_content "0009999"
        expect(page).to have_content "沖縄県那覇市"
        expect(page).to have_content "99999999999"
        expect(page).to have_content "mine@com"
        expect(page).to have_content "退会会員"
      end

    end
  end
end
