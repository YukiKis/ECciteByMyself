class Admin::AdminsController < ApplicationController
  after_action :delete_session, except: :search

  def top
    @count = Order.where("created_at >= ?", Date.today).count
  end

  def result
    keyword =session[:keyword]
    unless keyword.blank?
      if Customer.by_last_name(keyword).any?
        @resources = Customer.by_last_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
      elsif Customer.by_first_name(keyword).any?
        @resources = Customer.by_first_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
      elsif Item.by_name(keyword).any?
        @resources = Item.by_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @items.count } #{ "item".pluralize(@items.count) }"
      else
       flash.now[:notice] = "Nothing found"
      end
    else
      flash.now[:notice] =  "キーワードが必要です。"
    end
  end

  def search
    keyword = search_params[:keyword]
    session[:keyword] = keyword
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

    def delete_session
      session.delete(:keyword)
    end
end
