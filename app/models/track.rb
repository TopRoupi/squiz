class Track < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def spotify_track
    RSpotify::Track.find(track_id)
  end

  def choices
    artist = spotify_track.artists.first

    tracks = []

    artist.albums.each do |album|
      tracks << album.tracks
    end

    tracks.flatten!

    choices = [spotify_track]

    4.times do
      choices << tracks.sample
    end

    choices.shuffle
  end
end
