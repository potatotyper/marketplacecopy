class PasswordResetController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to index_path, notice: "If an account with that email exists, we have sent a link to reset the password."
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "reset_password")
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "reset_password")
    if @user.present?
      if @user.update(password_params)
       redirect_to sign_in_path, notice: "Your password was reset successfully, please sign in."
      else
        render :edit
      end
    end
  end

  private
  
  def password_params 
    params.require(:user).permit(:password, :password_confirmation)
  end
end