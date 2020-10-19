require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "on validation" do
    let(:customer1){ build(:customer1) }
    it "has many cart_items" do
      expect(Customer.reflect_on_association(:cart_items).macro).to eq :has_many
    end
    it "has many deliveries" do
      expect(Customer.reflect_on_association(:deliveries).macro).to eq :has_many
    end
    it "has many orders" do
      expect(Customer.reflect_on_association(:orders).macro).to eq :has_many
    end
    it "is valid" do
      expect(customer1).to be_valid
    end
    it "is invalid without last_name" do
      customer1.last_name = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without first_name" do
      customer1.first_name = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without last_name_kana" do
      customer1.last_name_kana = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without first_name_kana" do
      customer1.first_name_kana = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without email" do 
      customer1.email = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without password" do
      customer1.password = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without postal_code" do
      customer1.postcode = nil
      expect(customer1).to be_invalid
    end
    it "is invalid wihtout address" do
      customer1.address = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without telephone_number" do
      customer1.tel = nil
      expect(customer1).to be_invalid
    end
    it "is invalid without custoemr_judge?" do
      customer1.is_active = nil
      expect(customer1).to be_invalid
    end
  end
end