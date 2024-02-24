class Admin::GenresController < ApplicationController
# 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def create # ifで実行できなかった時の動き
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update # ifで実行できなかった時の動き
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
