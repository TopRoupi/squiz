class User < ApplicationRecord
  def selected_tracks_on_room(room)
    room.tracks.where(user: self).to_a.map(&:spotify_track)
  end
end
