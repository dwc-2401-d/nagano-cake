class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)  # カート内容一覧
    @shipping_cost = 800  # 送料は固定
    @order = Order.new(order_params)
    @selected_pay_method = params[:order][:pey_method]  # 支払方法のパラメータの値を取得
    @cart_items_price = @cart_items.sum { |cart_item| cart_item.item.with_tax_price * cart_item.amount }  # 商品金額合計
    @total_payment = @shipping_cost + @cart_items_price  # 請求金額

    @address_type = params[:order][:select_address]
    # 配送先の分岐
    case @address_type
    when "customer_address"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when "registered_address"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    when "new_address"
      @order.customer_id = current_customer.id
    end
  end

  def thanks
  end

  def create
    @cart_items = current_customer.cart_items.all  # カート内商品の情報を取得
    @order = Order.new(order_params)
    @order.save

    # OrderDetailに渡す値を設定
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.with_tax_price
      @order_details.amount = cart_item.amount
      @order_details.making_status = 0
      @order_details.save!
    end

    CartItem.destroy_all
    redirect_to thanks_public_orders_path
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @cart_item = CartItem.where(customer_id: current_customer.id) 
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :post_code, :address, :name, :total_payment, :shipping_cost, :status)
  end
end
