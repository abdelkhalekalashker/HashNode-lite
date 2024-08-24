class RoomsController < ApplicationController
  def index
    redirect_to '/signin' unless current_user
    @rooms = Room.public_rooms
    @users = User.all
  end

  def show
    @room = Room.find(params[:id])
    if @room.present?
      render :show, status: :ok
    else
      render json: "could not find a room", status: :not_found
    end
  end
end
