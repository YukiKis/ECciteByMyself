require 'rails_helper'

RSpec.describe "Public::Customers", type: :system do
  describe "about customer page" do
    let(:customer1){ create(:customer1) }
    before do
      visit new_customer_session_path
      fill_in "customer[email]", with: customer1.email
      fill_in "customer[password]", with: customer1.password
      click_button "ログイン"
    end
    context "on customer-show page" do
      before do
        visit customers_path
      end
      it "has 'マイページ'" do
        expect(page).to have_content "マイぺージ"
      end
      it "has button for editing customer info" do
        expect(page).to have_link "編集する", href: edit_customers_path
      end
      it "has button for going to change password" do
        expect(page).to have_link "パスワードを変更する", href: edit_customer_password_path
      end
      it "has table-header for customer info" do
        expect(page).to have_content "登録情報"
        expect(page).to have_content "氏名"
        expect(page).to have_content "カナ"
        expect(page).to have_content "郵便番号"
        expect(page).to have_content "住所"
        expect(page).to have_content "電話番号"
        expect(page).to have_content "メールアドレス"
      end
      it "has info for customer" do
        expect(page).to have_content customer1.full_name_with_space
        expect(page).to have_content customer1.full_name_kana_with_space
        expect(page).to have_content customer1.postcode
        expect(page).to have_content customer1.address
        expect(page).to have_content customer1.tel
        expect(page).to have_content customer1.email
      end
      it "has button for delivery-index" do
        expect(page).to have_content "配送先"
        expect(page).to have_link "一覧を見る", href: deliveries_path
      end
      it "has button for order-index" do
        expect(page).to have_content "注文履歴"
        expect(page).to have_link "一覧を見る", href: orders_path
      end
    end
    context "on customer-quit page" do
      before do
        visit quit_path
      end
      it "has '本当に退会しますか？" do
        expect(page).to have_content "本当に退会しますか？"
      end
      it "has sentences for explaining" do
        expect(page).to have_content "退会すると、"
      end
      it "has button for not quit" do
        expect(page).to have_link "退会しない", href: customers_path
      end
      it "has button for out" do
        expect(page).to have_button "退会する"
      end
      it "succeeds to quit" do
        page.accept_confirm do
          click_button "退会する"
        end
        expect(current_path).to eq root_path
      end
    end
    context "on customer-edit page" do
      before do
        visit edit_customers_path
      end
      it "has '登録情報編集'" do
        expect(page).to have_content "登録情報編集"
      end
      it "has table-heading for customer-info" do
        expect(page).to have_content "名前"
        expect(page).to have_content "姓"
        expect(page).to have_content "名"
        expect(page).to have_content "フリガナ"
        expect(page).to have_content "セイ"
        expect(page).to have_content "メイ"
        expect(page).to have_content "メールアドレス"
        expect(page).to have_content "郵便番号(ハイフンなし)"
        expect(page).to have_content "住所"
        expect(page).to have_content "電話番号(ハイフンなし)"
      end
      it "has customer-info" do
        expect(page).to have_field "customer[last_name]", with: customer1.last_name
        expect(page).to have_field "customer[first_name]", with: customer1.first_name
        expect(page).to have_field "customer[last_name_kana]", with: customer1.last_name_kana
        expect(page).to have_field "customer[first_name_kana]", with: customer1.first_name_kana
        expect(page).to have_field "customer[email]", with: customer1.email
        expect(page).to have_field "customer[postcode]", with: customer1.postcode
        expect(page).to have_field "customer[address]", with: customer1.address
        expect(page).to have_field "customer[tel]", with: customer1.tel
      end
      it "has button to save" do
        expect(page).to have_button "編集内容を保存する"
      end
      it "has link_to quit" do
        expect(page).to have_link "退会する", href: quit_path
      end
      it "succeeds to change customer info" do
        fill_in "customer[tel]", with: "00000000000"
        click_button "編集内容を保存する"
        expect(current_path).to eq customers_path
        expect(page).to have_content "00000000000"
      end
      it "fails to change info" do
        fill_in "customer[last_name]", with: ""
        click_button "編集内容を保存する"
        expect(page).to have_content "error"
      end
    end
  end
end
