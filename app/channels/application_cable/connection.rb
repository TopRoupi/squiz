module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :logged_user

    def connect
      user_id = cookies.encrypted[:user_id]
      return reject_unauthorized_connection if user_id.nil?
      user = User.find_by(id: user_id)
      return reject_unauthorized_connection if user.nil?
      self.logged_user = user
    end
  end
end
