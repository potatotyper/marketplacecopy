class Api::V1::TextpostsController < ApplicationController
  def index 
    @posts = Textpost.all
    render json: @posts
  end

  def create
    json_data = JSON.parse(request.raw_post)
    puts "REQUEST BELOW"
    puts request.url
    puts request.body
    @post = Textpost.new json_data
    render json: @post
  end

end
