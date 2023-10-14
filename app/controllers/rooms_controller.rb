class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :leave]

  def show
    @room.users_presences << logged_user unless @room.users_presences.any? logged_user

    render Rooms::ShowView.new(room: @room, user: logged_user)
  end

  def leave
    # @room.users_presences.delete(logged_user)
    @room.presences.where(user: logged_user).destroy_all

    redirect_to :root
  end

  def create
    room = Room.create(owner: logged_user, max_users: 6, invite_code: SecureRandom.base64(6))
    Game.create(room: room)
    redirect_to :root
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
