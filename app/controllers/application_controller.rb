class ApplicationController < ActionController::Base
  layout -> { ApplicationLayout }
  before_action :authenticate_user!, except: [:register, :setup]

  def authenticate_user!
    if session[:user_id].nil?
      redirect_to users_register_path
    end
  end

  private

  def logged_user
    User.find(session[:user_id])
  end
end
