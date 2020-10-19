require 'rails_helper'

RSpec.describe Item, type: :model do
  context "on validateion" do
    let(:category1){ create(:category1) }
    let(:item1){ build(:item1, category_id: category1.id) }
    it "has_many cart_items" do
      expect(Item.reflect_on_association(:cart_items).macro).to eq :has_many
    end
    it "has_many order_details" do
      expect(Item.reflect_on_association(:order_items).macro).to eq :has_many
    end
    it "belongs to genre" do
      expect(Item.reflect_on_association(:category).macro).to eq :belongs_to
    end
    it "is valid" do
      expect(item1).to be_valid
    end
    it "is invalid without name" do
      item1.name = nil
      expect(item1).to be_invalid
    end
    it "is invalid without genre_id" do
      item1.category_id = nil
      expect(item1).to be_invalid
    end
    it "is invalid with genre_id with string" do
      item1.category_id = "AAA"
      expect(item1).to be_invalid
    end
    it "is invalid without image_id" do
      item1.image_id = nil
      expect(item1).to be_invalid
    end
    it "is invalid without introduction" do
      item1.description = nil
      expect(item1).to be_invalid
    end
    it "is invalid without price" do
      item1.price = nil
      expect(item1).to be_invalid
    end
    it "is invalid with price with string" do
      item1.price = "AAA"
      expect(item1).to be_invalid
    end
    it "is invalid without is_active" do
      item1.is_active = nil
      expect(item1).to be_invalid
    end
  end
end
