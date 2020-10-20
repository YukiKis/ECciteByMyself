class Admin::AdminsController < ApplicationController
  def top
    @count = Order.where("created_at >= ?", Date.today).count
  end
end
