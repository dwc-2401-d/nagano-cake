class Admin::ItemsController < ApplicationController
# 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create # ifで実行できなかった時の動き
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update # ifで実行できなかった時の動き
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :genre_id, :price, :is_active)
  end
end
