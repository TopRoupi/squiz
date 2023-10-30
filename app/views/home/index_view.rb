# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def template
    h1 class: "header" do
      "Game Rooms"
    end

    Room.all.each do |room|
      # p class: "mb-3" do
      #   plain room.invite_code
      #   plain " (#{room.presences.size}/#{room.max_users})"
      #   link_to "enter", room_path(room), class: "btn !p-1 ml-2"
      # end
      div(class: "card flex flex-row justify-between p-4 w-full bg-base-100 border-2 border-base-200 shadow-xl mb-5") do
        div class: "w-fit" do
          h2(class: "font-semibold") { room.invite_code }
          p { " #{room.presences.size}/#{room.max_users}" }
        end
        link_to("enter", room_path(room), class: "btn btn-outline")
      end
    end

    button_to "new room", rooms_path, method: :post, class: "block ml-auto btn btn-outline btn-primary mt-10"
  end
end
