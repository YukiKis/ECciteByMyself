class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.page(params[:page]).order(id: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
  end

  def today
    @orders = Order.today.page(params[:page]).order(id: :desc)
    render "index"
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end
end
