class Admin::GenresController < ApplicationController

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def index
    @genres = Genre.all
  end

  def edit
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.permit(:name)
  end

end
