require 'rails_helper'

RSpec.describe "CartItems", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/cart_item/index"
      expect(response).to have_http_status(:success)
    end
  end

end
