class MainController < ApplicationController
    skip_before_action :authorized, only: [:index]
    def index
        if flash[:notice] == nil
            flash[:notice] = "Welcome to my page!"
        end
    end
end