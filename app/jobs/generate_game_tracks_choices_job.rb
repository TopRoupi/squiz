class GenerateGameTracksChoicesJob
  include Sidekiq::Worker

  include CableReady::Broadcaster
  include Rails.application.routes.url_helpers
  delegate :render, to: :ApplicationController

  sidekiq_options retry: false

  def perform(game_id)
    game = Game.find(game_id)

    room = game.room
    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    game.tracks.each do |track|
      track.generate_choices
      game.reload
      cable_ready[ApplicationChannel]
        .morph(
          selector: "#choices-generation",
          children_only: true,
          html: ApplicationController.renderer.render(
            ChoicesGenerationComponent.new(game: game),
            layout: false
          )
        )
        .broadcast_to(stream_id)
    end
  end
end
