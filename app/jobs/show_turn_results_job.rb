class ShowTurnResultsJob
  include Sidekiq::Worker
  include CableReady::Broadcaster
  include Rails.application.routes.url_helpers
  delegate :render, to: :ApplicationController

  sidekiq_options retry: false

  def perform(room_id)
    room = Room.find(room_id)
    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    result_choice = room.current_game.next_track.choices.where(decoy: false).last

    cable_ready[ApplicationChannel]
      .set_attribute(
        selector: dom_id(room.current_game.next_track, "choices"),
        name: "data-picks-result-value",
        value: result_choice.id
      )
      .broadcast_to(stream_id)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "##{room_dom_id}",
        html: rendered_room_presence(room)
      )
      .broadcast_to(stream_id)
  end

  private

  def rendered_room_presence(room)
    ApplicationController.renderer.render(
      RoomPlayerPresenceComponent.new(room: room),
      layout: false
    )
  end
end
