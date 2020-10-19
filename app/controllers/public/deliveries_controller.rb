class Public::DeliveriesController < ApplicationController
  before_action :setup, only: [:index, :show]

  def setup
    @customer = current_customer
  end

  def index
    @delivery_new = @customer.deliveries.new
    @deliveries = @customer.deliveries
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end
end
