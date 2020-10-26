class Public::HomesController < ApplicationController
  def top
    @items = Item.all[0..3]
  end

  def about

  end
end
