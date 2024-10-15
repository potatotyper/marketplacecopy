class MainController < ApplicationController
    skip_before_action :authorized, only: [:index]
    def index
        if flash[:notice] == nil
            REDIS.set("welcome_key", "Hello from Redis!")
            redis_notice = REDIS.get("welcome_key")
            if redis_notice == "Hello from Redis!" 
                flash[:notice] = redis_notice
            else
                flash[:notice] = "Welcome to my page!"
            end
        end
    end
end