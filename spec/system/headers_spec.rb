require 'rails_helper'

RSpec.describe "Headers", type: :system do
  describe "about header" do
    let(:customer1){ create(:customer1) }
    let(:admin1){ create(:admin1) }
    context "on header when not logged in" do
      before do
        visit root_path
      end
      it "has 'About'" do
        expect(page).to have_link "About", href: about_path
      end
      it "has '商品一覧'" do
        expect(page).to have_link "商品一覧", href: items_path
      end
      it "has '新規登録'" do
        expect(page).to have_link "新規登録", href: new_customer_registration_path
      end
      it "has 'ログイン'" do
        expect(page).to have_link "ログイン", href: new_customer_session_path
      end
    end
    context "on header when logged in as a customer" do
      before do
        visit new_customer_session_path
        fill_in "customer[email]", with: customer1.email
        fill_in "customer[password]", with: customer1.password
        click_button "ログイン"
      end
      it "has welcome message" do
        expect(page).to have_content "ようこそ、#{customer1.full_name_with_space}さん！"
      end
      it "has 'マイページ'" do
        expect(page).to have_link "マイページ", href: customers_path
      end
      it "has カート'" do
        expect(page).to have_link "カート", href: cart_items_path
      end
      it "has 'ログアウト'" do
        expect(page).to have_link "ログアウト", href: destroy_customer_session_path
      end
    end
    context "on header when logged in as an admin" do
      before do
        visit new_admin_session_path
        fill_in "admin[email]", with: admin1.email
        fill_in "admin[password]", with: admin1.password
        click_button "ログイン"
      end
      it "has '商品一覧'" do
        expect(page).to have_link "商品一覧", href: admin_items_path
      end
      it "has 会員一覧" do
        expect(page).to have_link "会員一覧", href: admin_customers_path
      end
      it "has '注文履歴一覧'" do
        expect(page).to have_link "注文履歴一覧", href: admin_orders_path
      end
      it "has 'ジャンル一覧'" do
        expect(page).to have_link "ジャンル一覧", href: new_admin_category_path
      end
      it "has ログアウト" do
        expect(page).to have_link "ログアウト", href: destroy_admin_session_path
      end
    end
  end
end