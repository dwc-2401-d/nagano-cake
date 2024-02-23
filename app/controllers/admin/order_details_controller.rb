class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  # 管理者でないユーザーが不正な操作を行うことを防ぐ
  
  # making_statusが"manufacturing"の場合、関連するOrderのstatusを"making"に更新
  # making_statusが"finish"の場合、Orderに含まれる全てのOrderDetailのmaking_statusが"finish"である場合
  # Orderのstatusを"preparing_ship"に更新
  # OrderDetailのmaking_statusが"finish"をチェック　
  # 条件式は、Orderに含まれる全てのOrderDetailのmaking_statusが"finish"である場合にtrueで返す
  
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    
    case order_detail.making_status
    when "waiting_manufacture"
      order_detail.order.update(status: "making")
    when "finish"
      if order_detail.order.order_details.all? { |detail| detail.making_status == "finish" }
        order_detail.order.update(status: "preparing_ship")
      end
    end
    
    redirect_to admin_order_path(order_detail.order.id)
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
