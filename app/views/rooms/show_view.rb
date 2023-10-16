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

    div(
      data: {
        controller: "picks",
        picks_disabled_value: true,
        picks_picked_value: "eff0b8ab-59d6-4cfe-bbfb-ba46d454b8e1",
        picks_result_value: "af0fa546-b2da-4b46-ace2-053199346e81"
      }
    ) do
      Track.find("fe3e64cb-0422-4e04-bc5e-1b0d77e5efb6").choices.each do |choice|
        button(id: choice.id, data: {picks_target: "choice"}) { choice.name }
      end
    end
  end
end
