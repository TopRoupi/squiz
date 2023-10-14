class GenerateGameTracksChoicesJob
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(game_id)
    game = Game.find(game_id)
    game.tracks.each do |track|
      track.generate_choices
    end
  end
end
