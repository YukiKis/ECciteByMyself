class Public::CustomersController < ApplicationController
  before_action :setup
  before_action :authenticate_customer!

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
    @customer = current_customer
  end

  def out
    current_customer.update(for_quit_params)
    session.clear
    redirect_to root_path, notice: "またのご利用お待ちしております。"
    debugger
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :tel, :email)
    end
    def for_quit_params
      params.require(:customer).permit(:is_active)
    end
end
