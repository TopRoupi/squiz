class Rooms::ShowView < ApplicationView
  def initialize(room:)
    @room = room
  end

  def template
    render RoomPlayerPresenceComponent.new(room: @room)

    if @room.owner == helpers.logged_user
      div id: "start-button" do
        button(data: {reflex: "click->RoomReflex#start_game", room_id: @room.signed_id}) { "start game" }
      end
    end

    div id: "room-header" do
    end

    button_to "leave", room_presence_leave_path(@room), method: :post
  end
end
