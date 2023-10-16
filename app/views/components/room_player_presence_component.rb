# frozen_string_literal: true

class RoomPlayerPresenceComponent < ApplicationComponent
  def initialize(room:)
    @room = room
  end

  def template
    div(
      id: dom_id(@room),
      class: "border-solid border-2 border-gray-900 p-2 mb-2",
      data: {
        controller: "cable-from",
        cable_from_id_value: Cable.signed_stream_name(dom_id(@room))
      }
    ) do
      span class: "font-semibold" do
        "users in the room:"
      end
      @room.users_presences.each_with_index do |user, i|
        p do
          "#{i + 1}. #{user.name} | points: #{user.points_on_room(@room)}"
        end
      end
    end
  end
end
