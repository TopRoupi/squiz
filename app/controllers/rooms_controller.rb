class RoomsController < ApplicationController
  def create
    Room.create(owner: User.find(session[:user_id]), max_users: 6, invite_code: SecureRandom.base64(6))
    redirect_to :root
  end
end
