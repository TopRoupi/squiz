class PlayersSelectedTracksComponent < ApplicationComponent
  def initialize(game:)
    @game = game
    @players = game.room.users_presences
  end

  def template
    @players.each do |player|
      div class: "flex justify-between" do
        span { player.name }
        span { "selected #{player.count_selected_tracks_on_game(@game)}/#{@game.tracks_limit} tracks" }
      end
    end
  end
end
