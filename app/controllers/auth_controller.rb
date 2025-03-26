class AuthController < ApplicationController
  skip_before_action :authorized, only: [:login, :new, :logout]
  
  def new
    @user = User.new
  end

  def login 
      puts "PARAMS HERE", params.inspect
      puts login_params
      @user = User.find_by(username: login_params[:username])
      if @user == nil 
        flash[:alert] = "Invalid Log In"
        Current.user = nil
        render :new
      elsif @user.authenticate(login_params[:password])
          @token = encode_token(user_id: @user.id)
          Current.user = @user
          puts "CURRENT USER SET"
          cookies[:jwt] = {
            value: @token,
            expires: 1.hour.from_now, # Set expiration time
            httponly: true, # Ensure the cookie is HttpOnly
            secure: Rails.env.production? # Set secure flag in production
          }
          puts "What is this?", cookies[:jwt], "A COOKIEE"
          puts Current.user.id
          redirect_to index_path, notice: @token
      else
        flash[:alert] = "Invalid Log In"
        Current.user = nil
        render :new
      end

  end

  def logout
    cookies.delete(:jwt, httponly: true)
    Current.user = nil
    redirect_to root_path, notice: "Logged out"
  end

  private 

  def login_params 
      params.require(:user).permit(:username, :password)
  end

  def handle_record_not_found(e)
      render json: { message: "User doesn't exist" }, status: :unauthorized
  end
end
