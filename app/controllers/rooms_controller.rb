class RoomsController < ApplicationController

  def index
    @current_user = Current.user
    puts "USERNAME IS"
    puts @current_user.username
    redirect_to '/' unless @current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
  end

  def show
    @current_user = Current.user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages
  
    render "index"
  end
end