class EndTrackSelectionJob
  include Sidekiq::Worker
  include CableReady::Broadcaster
  include Rails.application.routes.url_helpers
  delegate :render, to: :ApplicationController

  sidekiq_options retry: false

  def perform(room_id)
    room = Room.find(room_id)
    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    GenerateGameTracksChoicesJob.perform_inline(room.current_game.id)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "#room-header",
        html: render(RoomHeaderComponent.new(room: room, state: :guessing))
      )
      .replace(
        selector: "#room-body",
        html: render(RoomBodyComponent.new(room: room, state: :guessing))
      )
      .broadcast_to(stream_id)

    AdvanceToNextTrackJob.perform_in(Room.track_guess_time, room.id)
  end
end
