class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def new
    @order = current_customer.orders.new
  end

  def thanks
  end

  def log
    @order = current_customer.orders.new
    @order.set_order_items(current_customer)
    @order.set_total_price
    @order_items = @order.order_items
    @order.how_to_pay = order_params[:how_to_pay]
    case order_params[:address_select]
    when "1"
      @order.deliver_postcode = current_customer.postcode
      @order.deliver_address = current_customer.address
      @order.deliver_name = current_customer.full_name
    when "2"
      order_place = order_params[:address_where].split
      @order.deliver_postcode = order_place[0]
      @order.deliver_address = order_place[1]
      @order.deliver_name = order_place[2]
    when "3"
      @order.deliver_postcode = order_params[:deliver_postcode]
      @order.deliver_address = order_params[:deliver_address]
      @order.deliver_name = order_params[:deliver_name]
      current_customer.deliveries.create(
        postcode: order_params[:deliver_postcode],
        address: order_params[:deliver_address],
        name: order_params[:deliver_name]
      )
    end
    session[:order] = @order
  end

  def create
    @order = Order.new(session[:order])
    @order.set_order_items(current_customer)
    session.delete(:order)
    if @order.save
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render "log"
    end
  end


    protected
      def order_params
        params.require(:order).permit(:how_to_pay, :address_where, :address_select, :deliver_postcode, :deliver_address, :deliver_name)
      end
end
