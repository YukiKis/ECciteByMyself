require 'rails_helper'

RSpec.describe "Adnub::Homes", type: :system do
  describe "admin_home page" do
    let(:admin1){ create(:admin1) }
    context "on admin_login page" do
      before do 
        visit new_admin_session_path
      end
      it "has '管理者ログイン'" do
        expect(page).to have_content "管理者ログイン"
      end
      it "has fields to login" do
        expect(page).to have_field "admin[email]"
        expect(page).to have_field "admin[password]"
      end
      it "has button to login" do
        expect(page).to have_button "ログイン"
      end
      it "succeeds to login" do
        fill_in "admin[email]", with: admin1.email
        fill_in "admin[password]", with: admin1.password
        click_button "ログイン"
        expect(current_path).to eq admin_top_path
      end
      it "fails to login" do
        click_button "ログイン"
        expect(current_path).to eq new_admin_session_path
        expect(page).to have_content "Invalid Email or password"
      end
    end
    context "on admin top page" do
      before do 
        visit new_admin_session_path
        fill_in "admin[email]", with: admin1.email
        fill_in "admin[password]", with: admin1.password
        click_button "ログイン"
      end
      it "has '本日の注文件数" do
        expect(page).to have_content "本日の注文件数"
      end
      it "has counts of today's orders" do
      end
      it "has items-index" do
        expect(page).to have_link "商品一覧", href: admin_items_path
      end
      it "has customers-index" do
        expect(page).to have_link "会員一覧", href: admin_customers_path
      end
      it "has orders-index " do
        expect(page).to have_link "注文履歴一覧", href: admin_orders_path
      end
      it "has categories-index" do
        expect(page).to have_link "ジャンル一覧", href: new_admin_category_path
      end
      it "has logout button" do
        expect(page).to have_link "ログアウト", href: destroy_admin_session_path
      end
    end
  end
end
