require 'rails_helper'

RSpec.describe Order, type: :model do
  context "on validation" do
    let(:customer1){ create(:customer1) }
    let(:order1){ build(:order1, customer_id: customer1.id) }
    it "belongs to customer" do 
      expect(Order.reflect_on_association(:customer).macro).to eq :belongs_to
    end
    it "has many order_details" do
      expect(Order.reflect_on_association(:order_items).macro).to eq :has_many
    end
    it "is valid" do
      expect(order1).to be_valid
    end
    it "is invalid without customer_id" do
      order1.customer_id = nil
      expect(order1).to be_invalid
    end
    it "is invalid without postal_code" do
      order1.deliver_postcode = nil
      expect(order1).to be_invalid
    end
    it "is invalid wihtout address" do
      order1.deliver_address = nil
      expect(order1).to be_invalid
    end
    it "is invalid without name" do
      order1.deliver_name = nil
      expect(order1).to be_invalid
    end
    it "is invalid without deliver_fee" do
      order1.deliver_fee = nil
      expect(order1).to be_invalid
    end
    it "is invalid without total_price" do
      order1.total_price = nil
      expect(order1).to be_invalid
    end
    it "is invalid without how_to_pay" do
      order1.how_to_pay = nil
      expect(order1).to be_invalid
    end
    it "is invalid without order status" do
      order1.status = nil
      expect(order1).to be_invalid
    end
  end
end
