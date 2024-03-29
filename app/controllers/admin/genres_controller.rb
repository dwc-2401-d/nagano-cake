class Admin::GenresController < ApplicationController
# 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      @genres = Genre.all
    else
      redirect_to request.referer
    end
  end

  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(5)
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      redirect_to request.referer
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
