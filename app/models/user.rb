class User < ApplicationRecord
  def selected_tracks_on_game(game)
    game.tracks.where(user: self).to_a.map(&:spotify_track)
  end
end
