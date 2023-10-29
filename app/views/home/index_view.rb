# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def template
    div(data_controller: "hello") { "d" }

    h1 class: "header" do
      "Game Rooms"
    end

    Room.all.each do |room|
      p class: "mb-3" do
        plain room.invite_code
        plain " (#{room.presences.size}/#{room.max_users})"
        link_to "enter", room_path(room), class: "btn !p-1 ml-2"
      end
    end

    button_to "new room", rooms_path, method: :post, class: "btn"
  end
end
