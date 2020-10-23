class Admin::OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(order_item_params)
    order = order_item.order
    @order_items = order.order_items
  end

  private 
    def order_item_params
      params.require(:order_item).permit(:status)
    end
end
