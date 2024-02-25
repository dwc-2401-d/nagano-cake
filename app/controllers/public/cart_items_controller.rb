class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #カートの状態によって分岐
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present? #カートに追加しようとした商品がすでにカートあった場合
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) #これから追加する商品と同じ名前の商品を探す
      @cart_item.amount += params[:cart_item][:amount].to_i #元々あった商品の個数を呼び出し、整数形に変換し、追加した商品の数量に加算する
      @cart_item.save #保存
      redirect_to public_cart_items_path
    else #カートに追加しようとした商品がカートにない場合
      @cart_item.save
      redirect_to public_cart_items_path
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path
    else 
      redirect_to request.referer
    end 
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

end
