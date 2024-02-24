# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected

  # アクティブであることを判断する処理
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])  # 1,入力されたemailからアカウントを１件取得
    return if @customer.nil?  # 2,アカウントを取得できなかった場合、メソッドを終了
    return unless @customer.valid_password?(params[:customer][:password])  # 3,取得したアカウントのパスワードが一致していない場合、メソッドを終了
    if @customer.is_active  # 4,アクティブでない会員に対する処理
      sign_in(@customer)
      redirect_to root_path
    else
      flash[:notice] = "既に退会済みのアカウントです。新規会員登録が必要になります。"
      redirect_to new_customer_registration_path
    end
  end

end
