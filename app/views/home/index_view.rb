# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def template
    button_to "new room", rooms_path, method: :post

    Room.all.each do |room|
      p do
        plain room.invite_code
        plain " (#{room.presences.size}/#{room.max_users})"
        link_to "enter", room_path(room)
      end
    end
  end
end
