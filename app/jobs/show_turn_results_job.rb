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

    room.current_game.next_track.choices.each do |choice|
      dom_id(choice, "button")

      cable_ready[ApplicationChannel]
        .set_attribute(
          selector: dom_id(choice, "button"),
          name: "disabled",
          value: "true"
        )
        .broadcast_to(stream_id)

      if choice.decoy == false
        cable_ready[ApplicationChannel]
          .add_css_class(
            selector: dom_id(choice, "button"),
            name: "bg-green-400"
          )
          .broadcast_to(stream_id)
      end
    end
  end
end
