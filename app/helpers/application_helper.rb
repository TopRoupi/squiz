module ApplicationHelper
  def logged_user
    User.find(session[:user_id])
  end
end
