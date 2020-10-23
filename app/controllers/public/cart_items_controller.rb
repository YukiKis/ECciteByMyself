class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :setup

  def setup
    @cart_items = current_customer.cart_items
  end

  def index
  end
  
  def create
    if customer_signed_in?
      @cart_item = current_customer.cart_items.new(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path
      else
        @item = Item.find(cart_item_params[:item_id])
        render "public/items/show"
      end
    else
      redirect_to new_customer_session_path
    end
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
    @cart_items.reload
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.delete
    @cart_items.reload
  end

  def destroy_all
    current_customer.cart_items.each do |cart_item|
      cart_item.delete
    end
    @cart_items.reload
  end
  
  protected
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end
end
