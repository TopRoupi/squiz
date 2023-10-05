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
      new_user = User.create(name: params[:username])
      session[:user_id] = new_user.id
    end
    redirect_to :root
  end
end
