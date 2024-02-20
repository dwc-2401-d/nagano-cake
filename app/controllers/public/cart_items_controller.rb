class Public::CartItemsController < ApplicationController
  
  def create
  end 
  
  def index
    @cart_items = CartItem.all
  end 
  
  def update
  end 
  
  def destroy
  end 
  
  def destroy_all
  end 
  
  private
  
  def cart_item_params
  end 
  
end
