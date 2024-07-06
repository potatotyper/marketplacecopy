class MainController < ApplicationController
    def index
        if flash[:notice] == nil
            flash[:notice] = "Welcome to my page!"
        end
        if session[:user_id]
            @user = User.find_by(id: session[:user_id])
        end
    end
end