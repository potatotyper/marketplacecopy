# require_relative '..\..\app\services\googleauthservices.rb'
# class ApplicationController < ActionController::Base
#   before_action :set_current_user

#   def set_current_user
#     # if session[:user_id]
#     #   Current.user = User.find_by(id: session[:user_id])
#     # end
    
#   end

#   def authenticate_google_user
#     # token = Current.user.google_account.image 
#     reftoken = Current.user.google_account.refresh
#     token = Google::TokenRefresher.new(reftoken).refresh_access_token
#     if token
#         user_info = Google::verify_google_token token
#         if !user_info['error']
#             @current_gacc = GoogleAccount.find_by(email: user_info['email'])
#             @current_user = User.find_by(google_account: @current_gacc)
#         else
#             return render json: { error: 'Invalid token' }, status: :unauthorized
#             # render plain: "Unauthorized access"
#         end
#     else
#         return render json: { error: 'Token missing' }, status: :unauthorized
#         # render plain: "Unauthorized access"
#     end
#   end
# end

class ApplicationController < ActionController::Base
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, ENV['JWT_SECRET_TOKEN']) 
    end

    def decoded_token
        # puts("HEADER CALL")
        # header = request.headers['Authorization']
        # puts header, "header"
        # if header
        #   puts("HEADER SUCCESS")
        #     token = header.split(" ")[1]
        #     begin
        #         JWT.decode(token, ENV['JWT_SECRET_TOKEN'])
        #     rescue JWT::DecodeError
        #         nil
        #     end
        # end
        if cookies[:jwt]
          token = cookies[:jwt]
          begin
            JWT.decode(token, ENV['JWT_SECRET_TOKEN'])
          rescue JWT::DecodeError
            nil
          end
        end
    end

    def current_user 
      if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
          Current.user = @user
      end
  end
  
  def authorized
      unless !!current_user
      render json: { message: 'Please log in' }, status: :unauthorized
      end
  end
end