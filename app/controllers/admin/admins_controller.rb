class Admin::AdminsController < ApplicationController
  def top
    @count = Order.where("created_at >= ?", Date.today).count
  end

  def search
    keyword = search_params[:keyword]
    unless keyword.blank?
      if Customer.by_last_name(keyword).any?  
        @customers = Customer.by_last_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
        render "admin/customers/index"
      elsif Customer.by_first_name(keyword).any?
        @customers = Customer.by_first_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
        render "admin/customers/index"
      elsif Item.by_name(keyword).any?
        @items = Item.by_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @items.count } #{ "item".pluralize(@items.count) }"
        render "admin/items/index"
      else
        redirect_to request.referer, notice: "Nothing found"
      end
    else
      redirect_to request.referer, notice: "キーワードが必要です。"
    end
  end

    private
      def search_params
        params.require(:search).permit(:keyword)
      end
end
