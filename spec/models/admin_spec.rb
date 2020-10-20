require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "on validation" do
    let(:admin1){ build(:admin1) }
    it "is valid" do
      expect(admin1).to be_valid
    end
    it "is invalid without email" do
      admin1.email = nil
      expect(admin1).to be_invalid
    end
    it "is invalid without password" do
      admin1.password = nil
      expect(admin1).to be_invalid
    end
  end
end
