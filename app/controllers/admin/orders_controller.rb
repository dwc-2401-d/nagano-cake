class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  # 管理者でないユーザーが不正な操作を行うことを防ぐ

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @shipping_cost = 800  # 送料は固定
    @order_product_total = 0
    @order_details.each do |order_detail|
      order_total = order_detail.price * order_detail.amount
      @order_product_total += order_total
    end
  end

  # 条件分岐でorder.status == "confirm_paymentの条件がtrueの場合
  # making_status: "waiting_manufacture")`が実行される
  # making_status側が"waiting_manufacture"に変更されます


  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:order][:status])
    order_details = @order.order_details

    if @order.status == "confirm_payment"
      order_details.update_all(making_status: "waiting_manufacture")
    end

    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :post_code, :address, :payment_method, :status)
  end
end