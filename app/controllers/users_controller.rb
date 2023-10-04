class UsersController < ApplicationController
  def register
    if session[:user_id].nil?
      render Users::RegisterView.new
    else
      redirect_to(:root) 
    end
  end

  def setup
    if session[:user_id].nil?
      session[:user_id] = SecureRandom.base64(40)
      users = Kredis.hash "users"
      users.update(session[:user_id] => params[:username])
    end
    redirect_to :root
  end
end
