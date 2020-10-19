require 'rails_helper'

RSpec.describe "Public::Orders", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/public/orders/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/public/orders/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/public/orders/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /thanks" do
    it "returns http success" do
      get "/public/orders/thanks"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /log" do
    it "returns http success" do
      get "/public/orders/log"
      expect(response).to have_http_status(:success)
    end
  end

end
