class Public::HomesController < ApplicationController
  
  
  def top
    @items = Item.all
    @genres = Genre.where(valid_invalid_status: 0)
  end

  def about
  end
end
