require 'rails_helper'

RSpec.describe Delivery, type: :model do
  context "on validation" do
    let(:customer1){ create(:customer1) }
    let(:delivery1){ build(:delivery1, customer_id: customer1.id) }
    it "belongs_to customer" do
      expect(Delivery.reflect_on_association(:customer).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(delivery1).to be_valid
    end
    it "is invalid without customer_id" do
      delivery1.customer_id = nil
      expect(delivery1).to be_invalid
    end
    it "is invalid without name" do
      delivery1.name = nil
      expect(delivery1).to be_invalid
    end
    it "is invalid wihtout postal_code" do
      delivery1.postcode = nil
      expect(delivery1).to be_invalid
    end
    it "is invalid without address" do
      delivery1.address = nil
      expect(delivery1).to be_invalid
    end
  end
end
