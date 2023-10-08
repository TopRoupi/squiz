# frozen_string_literal: true

class RoomPlayerPresenceComponent < ApplicationComponent
  def initialize(room:)
    @room = room
  end

  def template
    div(
      id: dom_id(@room),
      data: {
        controller: "cable-from",
        cable_from_id_value: Cable.signed_stream_name(dom_id(@room))
      }
    ) do
      h1 { @room.invite_code }

      h1 { "users in the room: " }
      @room.users_presences.each_with_index do |user, i|
        p { "#{i + 1}. #{user.name}" }
      end
    end
  end
end
