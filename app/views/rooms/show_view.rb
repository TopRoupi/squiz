class Rooms::ShowView < ApplicationView
  def initialize(room:, user:)
    @room = room
    @user = user
  end

  def template
    render RoomPlayerPresenceComponent.new(room: @room)

    render RoomHeaderComponent.new(room: @room)
    render RoomBodyComponent.new(room: @room, user: @user)

    button_to "leave", room_presence_leave_path(@room), method: :post
  end
end
