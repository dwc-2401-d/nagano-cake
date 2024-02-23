class Admin::OrdersController < ApplicationController
　before_action :authenticate_admin 
　# 管理者でないユーザーが不正な操作を行うことを防ぐ
　
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  # 条件分岐でorder.status == "confirm_paymentの条件がtrueの場合
　# making_status: "waiting_manufacture")`が実行される
　# making_status側が"waiting_manufacture"に変更されます

　
  def update
    order = Order.find(params[:id])
    order_details = order.order_details
    order.update(order_params)

    if order.status == "confirm_payment"
      order_details.update_all(making_status: "waiting_manufacture")
    end

    redirect_to admin_order_path(order.id)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end