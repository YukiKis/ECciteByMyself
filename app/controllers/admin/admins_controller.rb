class Admin::AdminsController < ApplicationController
  def top
    @count = Order.where("created_at >= ?", Date.today).count
  end

  def search
    keyword = search_params[:keyword]
    if Customer.by_last_name(keyword).any?
      @customers = Customer.by_last_name(keyword)
      flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
      render "admin/customers/index"
    elsif Customer.by_first_name(keyword).any?
      @customers = Customer.by_first_name(keyword)
      flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
      render "admin/customers/index"
    elsif Item.by_name(keyword)
      @items = Item.by_name(keyword)
      flash.now[:notice] = "Found #{ @items.count } #{ "item".pluralize(@items.count) }"
      render "admin/items/index"
    end
  end

    private
      def search_params
        params.require(:search).permit(:keyword)
      end
end
