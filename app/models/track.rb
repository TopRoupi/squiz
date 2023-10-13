class Track < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def self.search_spotify_tracks(search)
    if search.blank?
      []
    else
      RSpotify::Track.search(search)
    end
  end

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
