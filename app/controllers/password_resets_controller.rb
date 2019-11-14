class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "已发送密码重置邮件，请尽快重置密码"
      redirect_to root_url
    else
      flash.now[:danger] = "无效邮箱地址"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty? 
      @user.errors.add(:password, "密码不能为空")
      render 'edit'
    elsif @user.update_attributes(user_params) 
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      log_out 
      flash[:success] = "密码已重置,请重新登陆" 
      redirect_to root_url
    else
      render 'edit' 
    end
  end

   private
      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end

      def get_user
        @user = User.find_by(email: params[:email])
      end

      def valid_user
        unless (@user && @user.activated? && @user.user_authenticated?(:reset, params[:id]))
          redirect_to root_url
        end
      end

      def check_expiration
        if @user.password_reset_expired?
          flash[:danger] = "Password reset has expired."
          redirect_to new_password_reset_url
        end
      end
end
