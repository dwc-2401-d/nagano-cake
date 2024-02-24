class Public::SearchesController < ApplicationController
  
  def genre_search
    @genre_id = params[:genre_id]
    @item = Item.where(genre_id: @genre_id)
    @genre = Genre.all
  end 
end 