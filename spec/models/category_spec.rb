require 'rails_helper'

RSpec.describe Category, type: :model do
  context "on validation" do
    let(:category1){ build(:category1) }
    it "has many items" do
      expect(Category.reflect_on_association(:items).macro).to eq :has_many
    end
    it "is valid" do
      expect(category1).to be_valid
    end
    it "is invalid without name" do
      category1.name = nil
      expect(category1).to be_invalid
    end
    it "is invalid with is_active except either true or false" do
      category1.is_active = nil
      expect(category1).to be_invalid
    end
  end
end
