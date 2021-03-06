class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    params = item_params
    params[:category] = Category.find_by(name: item_params[:category])
    if @item.update(params)
      redirect_to admin_item_path(@item)
    else
      render "edit"
    end
  end

  def new
    @item = Item.new
  end

  def create
    # imageMagickがないため？　エラー
    params = item_params
    params[:category] = Category.find_by(name: item_params[:name])
    @item = Item.new(params)
    @item.category = Category.find_by(name: item_params[:category])
    if @item.save
      redirect_to admin_items_path
    else
      render "new"
    end
    debugger
  end

  private
    def item_params
      params.require(:item).permit(:image, :name, :description, :category, :price, :is_active)
    end
end
