class Public::DeliveriesController < ApplicationController
  before_action :setup, only: [:index, :show, :create]
  before_action :authenticate_customer!

  def setup
    @customer = current_customer
  end

  def index
    @delivery_new = @customer.deliveries.new
    @deliveries = @customer.deliveries.all
  end

  def create 
    @deliver_new = @customer.deliveries.new(delivery_params)
    if @deliver_new.save
      redirect_to deliveries_path
    else
      render "index"
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path
    else 
      render "edit"
    end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to deliveries_path
  end

  def delivery_params
    params.require(:delivery).permit(:postcode, :address, :name)
  end
end
