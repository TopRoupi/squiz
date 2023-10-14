class GenerateGameTracksChoicesJob
  include Sidekiq::Worker
  include CableReady::Broadcaster
  include Rails.application.routes.url_helpers
  delegate :render, to: :ApplicationController

  sidekiq_options retry: false

  def perform(game_id)
    game = Game.find(game_id)
    game.tracks.each do |track|
      track.generate_choices
    end
  end
end
