class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
  end
  
  def create
    @cart_items = current_customer.cart_items.new(cart_item_params)
    if @cart_items.save
      redirect_to cart_items_path
    end
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.delete
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.each do |cart_item|
      cart_item.delete
    end
    redirect_to cart_items_path
  end
  
  protected
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end
end
