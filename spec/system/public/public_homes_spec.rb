require 'rails_helper'

RSpec.describe "Public::Homes", type: :system do
  describe "customer-home" do
    let(:customer1){ create(:customer1) }
    context "on login page" do
      before do 
        visit new_customer_session_path
      end
      it "has '会員の方はこちらからログイン'" do
        expect(page).to have_content "会員の方はこちらからログイン"
      end
      it "has fields to login" do
        expect(page).to have_content "メールアドレス"
        expect(page).to have_field "customer[email]"
        expect(page).to have_content "パスワード"
        expect(page).to have_field "customer[password]"
      end
      it "has button 'ログイン'" do
        expect(page).to have_button "ログイン"
      end
      it "has '登録がお済みでない方" do
        expect(page).to have_content "登録がお済みでない方"
      end
      it "has link to registration_path" do
        expect(page).to have_link "こちら", href: new_customer_registration_path
      end
      it "succeeds to login" do
        fill_in "customer[email]", with: customer1.email
        fill_in "customer[password]", with: customer1.password
        click_button "ログイン"
        expect(current_path).to eq items_path
      end
      it "fails to login" do
        click_button "ログイン"
        expect(current_path).to eq new_customer_session_path
        expect(page).to have_content "Invalid Email or password"
      end
    end
    context "on registration_page" do
      before do
        visit new_customer_registration_path
      end
      it "has name field" do
        expect(page).to have_content "名前"
        expect(page).to have_field "customer[last_name]"
        expect(page).to have_field "customer[first_name]"
      end
      it "has name_kana field" do
        expect(page).to have_content "フリガナ"
        expect(page).to have_field "customer[last_name_kana]"
        expect(page).to have_field "customer[first_name_kana]"
      end
      it "has field for eamil" do
        expect(page).to have_content "メールアドレス"
        expect(page).to have_field "customer[email]"
      end
      it "has field for postcode" do
        expect(page).to have_content "郵便番号(ハイフンなし)"
        expect(page).to have_field "customer[postcode]"
      end
      it "has field for address" do
        expect(page).to have_content "住所"
        expect(page).to have_field "customer[address]"
      end
      it "has field for tel" do
        expect(page).to have_content "電話番号(ハイフンなし)"
        expect(page).to have_field "customer[tel]"
      end
      it "has field for password" do
        expect(page).to have_content "パスワード(6文字以上)"
        expect(page).to have_field "customer[password]"
      end
      it "has field for password_confirmation" do
        expect(page).to have_content "パスワード(確認用)"
        expect(page).to have_field "customer[password_confirmation]"
      end
      it "has button to register" do
        expect(page).to have_button "新規登録"
      end
      it "has '既に登録済みの方" do
        expect(page).to have_content "既に登録済みの方"
      end
      it "has link to go to session_path" do
        expect(page).to have_link "こちら", href: new_customer_session_path
      end
      it "succeeds to make a new user" do
        fill_in "customer[last_name]", with: "山田"
        fill_in "customer[first_name]", with: "花子"
        fill_in "customer[last_name_kana]", with: "ヤマダ"
        fill_in "customer[first_name_kana]", with: "ハナコ"
        fill_in "customer[email]", with: "hoge@example.com"
        fill_in "customer[postcode]", with: "1500041"
        fill_in "customer[address]", with: "東京都渋谷区"
        fill_in "customer[tel]", with: "0368694700"
        fill_in "customer[password]", with: "testtest"
        fill_in "customer[password_confirmation]", with: "testtest"
        click_button "新規登録"
        expect(current_path).to eq items_path
      end
      it "fails to make a customer" do
        click_button "新規登録"
        expect(page).to have_content "error"
      end
    end
  end
end
