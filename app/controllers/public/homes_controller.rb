class Public::HomesController < ApplicationController
  def top
    # （'id DESC').limit(4)idの降順にソートし、上位4つのレコードを取得するためのコード
    @items = Item.all
    @genres = Genre.all
    @items = Item.order('id DESC').limit(4)
  end
  
  
  
  def about
  end
  
end
