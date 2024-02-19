class Public::ItemsController < ApplicationController
  
  # １ページに何個も表示する為,ページネーションを行うメソッドを適用。
  # page(params[page])　リクエストパラメーターの中から現在のページ番号を取得。
  # per(8)８件の指定が出来る。
  # ベネテーションの行った結果は全て@itemに格納、一覧ページに各データが表示出来る
  
  def index
     @items = Item.all
    @genres = Genre.all
    @item_count = Item.all
  end
  
  
  
  
#   def index
#   @items = Item.all.page(params[:page]).per(8)
#   end
# end

# 購入後のカートへ@cart_itemに変数を代入
# CartItemで新しいオブジェクトを作成する。

# 　def show
#     @item = Item.find(params[:id])
# @cart_item = CartItem.new カートアイテム作成後
end 
