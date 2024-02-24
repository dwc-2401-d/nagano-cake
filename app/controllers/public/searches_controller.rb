class Public::SearchesController < ApplicationController
  
  def genre_search
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id)
    @genres = Genre.all
  end 
end 