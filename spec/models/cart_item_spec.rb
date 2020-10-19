require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context "on validation" do
    let(:category1){ create(:category1) }
    let(:customer1){ create(:customer1) }
    let(:item1){ create(:item1, category_id: category1.id) }
    before do
      @cart_item = CartItem.create(customer: customer1, item: item1, amount: 3)
    end
    it "belongs to customer" do
      expect(CartItem.reflect_on_association(:customer).macro).to eq :belongs_to
    end
    it "belongs to item" do
      expect(CartItem.reflect_on_association(:item).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(@cart_item).to be_valid
    end
    it "is invalid without item_id" do
      @cart_item.item_id = nil
      expect(@cart_item).to be_invalid
    end
    it "is invalid without customer_id" do
      @cart_item.customer_id = nil
      expect(@cart_item).to be_invalid
    end
  end
end
