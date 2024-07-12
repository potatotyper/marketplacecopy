class MainController < ApplicationController
    def index
        if flash[:notice] == nil
            flash[:notice] = "Welcome to my page!"
        end
    end
end