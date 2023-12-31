class Rooms::ShowView < ApplicationView
  def initialize(room:, user:)
    @room = room
    @user = user
  end

  def template
    h1 class: "header" do
      @room.invite_code
    end

    div(
      data: {
        controller: "cable-from",
        cable_from_id_value: Cable.signed_stream_name(dom_id(@room))
      }
    ) {}

    render RoomPlayerPresenceComponent.new(room: @room)

    render RoomHeaderComponent.new(room: @room)
    render RoomBodyComponent.new(room: @room, user: @user)

    button_to "leave", room_presence_leave_path(@room), method: :post, class: "btn ml-auto block"
  end
end
