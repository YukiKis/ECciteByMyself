class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @title = "商品"
  end

  def search
    case params[:id]
    when "1"
      @items = Item.joins(:category).where("categories.name = ?", "ケーキ").page(params[:page])
      @title = "ケーキ"
    when "2"
      @items = Item.joins(:category).where("categories.name = ?", "焼き菓子").page(params[:page])
      @title = "焼き菓子"
    when "3"
      @items = Item.joins(:category).where("categories.name = ?","プリン").page(params[:page])
      @title = "プリン"
    when "4"
      @items = Item.joins(:category).where("categories.name = ?","アイスキャンディ").page(params[:page])
      @title = "アイスキャンディ"
    else
      @items = Item.page(params[:page])
      @title = "商品"
    end
    render "index"
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
