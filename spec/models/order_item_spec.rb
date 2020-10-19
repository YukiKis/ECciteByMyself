require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context "on validation" do
    let(:customer1){ create(:customer1) }
    let(:order1){ create(:order1, customer_id: customer1.id) }
    let(:category1){ create(:category1) }
    let(:item1){ create(:item1, category_id: category1.id) }
    before do
      @order_item = OrderItem.new(order_id: order1.id, item_id: item1.id, amount: 3, price: 800)
    end
    it  "belongs to order" do
      expect(OrderItem.reflect_on_association(:order).macro).to eq :belongs_to
    end
    it "belongs to item" do
      expect(OrderItem.reflect_on_association(:item).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(@order_item).to be_valid
    end
    it "is invalid without order_id" do
      @order_item.order_id = nil
      expect(@order_item).to be_invalid
    end
    it "is invalid without item_id" do
      @order_item.item_id = nil
      expect(@order_item).to be_invalid
    end
    it "is invalid without price" do
      @order_item.price = nil
      expect(@order_item).to be_invalid
    end
    it "is invalid without item amount" do
      @order_item.amount = nil
      expect(@order_item).to be_invalid
    end
    it "is invalid without make_status" do
      @order_item.status = nil
      expect(@order_item).to be_invalid
    end
  end

end
