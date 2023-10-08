class Rooms::ShowView < ApplicationView
  def initialize(room:)
    @room = room
  end

  def template
    render RoomPlayerPresenceComponent.new(room: @room)

    button_to "leave", room_presence_leave_path(@room), method: :post
  end
end
