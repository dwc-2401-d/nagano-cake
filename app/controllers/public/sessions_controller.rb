# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customr_state, only: [:create]
  
  
  # deviceのアクション機能がデフォルトで入っている為、new,creteアクションの記述なし
  # before_actionメソッドにて定義された時createだけアクション
  
  
  def after_sign_in_path_for(resource)
    public_top_path
  end

  def after_sign_out_path_for(resource)
    public_top_path
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

#会員の登録の際の会員確認のメソッド
# customerが入力したmail,passworが一致しているかの確認
# 会員ではない入力者へのメッセージ
# リダイレクトで新規会員登録ページ（new)へ移動する

  private
  
  def customr_state
    customer = Customer.find_by(email: params[:customer][:email])
    return if customer.nil?
    return unless customer.valid_password?(params[:customer][:password])
    unless customer.is_active
      flash[notice] = "退会されています"
      redirect_to new_customeer_registration_path
    end
  end


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
