class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def search
    case params[:id]
    when "1"
      @items = Item.joins(:category).where("categories.name = ?", "ケーキ")
    when "2"
      @items = Item.joins(:category).where("categories.name = ?", "焼き菓子")
    when "3"
      @items = Item.joins(:category).where("categories.name = ?","プリン")
    when "4"
      @items = Item.joins(:category).where("categories.name = ?","アイスキャンディ")
    else
      @items = Item.all
    end
    render "index"
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
