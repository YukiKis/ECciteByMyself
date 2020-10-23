class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :delete_session, except: [:log, :create]

  def index
    @orders = current_customer.orders.order(id: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def new
    @order = current_customer.orders.new
    unless current_customer.cart_items.present?
      redirect_to cart_items_path, notice: "商品が選択されておりません。"
    end
  end

  def thanks
    
  end

  def log
    #   @order = current_customer.orders.new
    #   @order.set_order_items(current_customer)
    #   @order.set_total_price
    #   @order_items = @order.order_items
    #   @order.how_to_pay = order_params[:how_to_pay]
    #   case order_params[:address_select]
    #   when "1"
    #     @order.deliver_postcode = current_customer.postcode
    #     @order.deliver_address = current_customer.address
    #     @order.deliver_name = current_customer.full_name
    #   when "2"
    #     order_place = order_params[:address_where].split
    #     @order.deliver_postcode = order_place[0]
    #     @order.deliver_address = order_place[1]
    #     @order.deliver_name = order_place[2]
    #   when "3"
    #     @order.deliver_postcode = order_params[:deliver_postcode]
    #     @order.deliver_address = order_params[:deliver_address]
    #     @order.deliver_name = order_params[:deliver_name]
    #   end
    #   session[:order] = @order
    # end
    @order = current_customer.orders.new
    @order_items = current_customer.cart_items
    @total_price = CartItem.total_price_with_tax(current_customer)
    if request.post?
      session[:how_to_pay] = order_params[:how_to_pay]
      session[:address_select] = order_params[:address_select]
      case order_params[:address_select]
      when "1"
        session[:postcode] = current_customer.postcode
        session[:address] = current_customer.address
        session[:name] = current_customer.full_name
      when "2"
         order_place = order_params[:address_where].split
         session[:postcode] = order_place[0]
         session[:address] = order_place[1]
         session[:name] = order_place[2]
      when "3"
         session[:postcode] = order_params[:deliver_postcode]
         session[:address] = order_params[:deliver_address]
         session[:name] = order_params[:deliver_name]
      end
    end    
  end

  def create
    #  if reload => error
    # @order = Order.new(session[:order])
    # @order.set_order_items(current_customer)
    # session.delete(:order)
    # if @order.save
    #   current_customer.cart_items.destroy_all
    #   redirect_to orders_thanks_path
    # else
    #   render "log"
    # end
    
    # if reload => OK
    @order = current_customer.orders.new(
      deliver_postcode: session[:postcode],
      deliver_address: session[:address],
      deliver_name: session[:name],
      how_to_pay: session[:how_to_pay]
    )
    @order.set_order_items(current_customer)
    @order.set_total_price

    if @order.save
      if session[:address_select] == "3"
      current_customer.deliveries.create(
        postcode: @order.deliver_postcode,
        address: @order.deliver_address,
        name: @order.deliver_name,
      )
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render "log"
    end
    
  end


    private
      def order_params
        params.require(:order).permit(:how_to_pay, :address_where, :address_select, :deliver_postcode, :deliver_address, :deliver_name)
      end

      def delete_session
        session.delete(:postcode)
        session.delete(:address)
        session.delete(:name)
        session.delete(:how_to_pay)
        session.delete(:address_select)
      end
end
