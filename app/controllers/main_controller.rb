class MainController < ApplicationController
    def index
        flash.now[:notice] = "Welcome to my page!"
    end
end