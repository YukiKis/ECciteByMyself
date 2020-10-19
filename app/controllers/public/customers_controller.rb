class Public::CustomersController < ApplicationController
  before_action :setup

  def setup
    @customer = current_customer
  end

  def index
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path
    else
      render "edit"
    end
  end

  def quit
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_lana_name, :first_kana_name, :postcode, :address, :tel, :email)
    end
end
