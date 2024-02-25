class Public::SearchesController < ApplicationController

  def genre_search
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id)
    @genres = Genre.all
  end

  def item_search
    @word = params[:word]
    @model = params[:model]
    if @model == "Item"
      @items = Item.looks(params[:search], params[:word])
    end
  end
end