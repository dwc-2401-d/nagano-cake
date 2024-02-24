class Public::HomesController < ApplicationController
  # （'id DESC').limit(4)idの降順にソートし、上位4つのレコードを取得するためのコード
  def top
    @items = Item.order('id DESC').limit(4)
  end
  
  def genre
    @genres = Genre.all
  end 
    
  def about
  end 
  
end 
