# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
    before_action :user_state, only: [:create]
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
  
    protected
  # 退会しているかを判断するメソッド
  def user_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @user.valid_password?(params[:user][:password])
    if @user.is_deleted
      # is_deletedがtrueの場合の処理
      redirect_to new_user_registration_path
      flash[:notice] = "ログインしたアカウントは退会済です。"
    else
      # is_deletedがfalseの場合の処理
    end
    else
    # パスワードが一致しない場合の処理
    end
  end
  
end
