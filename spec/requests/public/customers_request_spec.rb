require 'rails_helper'

RSpec.describe "Public::Customers", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/public/customers/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/public/customers/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /quit" do
    it "returns http success" do
      get "/public/customers/quit"
      expect(response).to have_http_status(:success)
    end
  end

end
