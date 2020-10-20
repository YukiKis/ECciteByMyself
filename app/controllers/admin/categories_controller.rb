class Admin::CategoriesController < ApplicationController
  def new
    @categories = Category.all
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to new_admin_category_path
    else
      render "edit"
    end
  end

  def create 
    @category = Category.create(category_params)
    redirect_to new_admin_category_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :is_active)
    end
end

