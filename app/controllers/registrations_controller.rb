class RegistrationsController < ApplicationController
    skip_before_action :authorized, only: [:create, :new]
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.status = :regular
        @token = encode_token(user_id: @user.id)
        if @user.save
            Current.user = @user
            cookies[:jwt] = {
            value: @token,
            expires: 1.hour.from_now, # Set expiration time
            httponly: true, # Ensure the cookie is HttpOnly
            secure: Rails.env.production? # Set secure flag in production
          }
            redirect_to root_path, notice: "User Created! Please log in."
        else
            render :new
        end
        # render json: {
        #     user: @user,
        #     token: @token
        # }, status: :created 
        # if @user.save
            # session[:user_id] = @user.id
        #     redirect_to index_path, notice: "Successfully created account!"
        # else
        #     render :new
        # end
    end

    def curr
        render json: current_user, status: :ok
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end