class Admin::CustomersController < ApplicationController
# 管理者以外はアクセスできないように

  def index
   @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update # ifで実行できなかった時の動き
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :post_code, :address, :telephone_number, :email, :is_active)
  end
  end
