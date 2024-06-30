class MainController < ApplicationController
    def index
        flash[:notice] = "Welcome to my page!"
    end
end