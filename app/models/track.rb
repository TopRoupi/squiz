class Track < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :choices

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

  def to_choice
    choice = spotify_track_to_choice(spotify_track)
    choice.decoy = false
    choice
  end

  def spotify_track_to_choice(strack)
    Choice.new(
      track: self,
      spotify_track_id: strack.id,
      album_name: strack.album.name,
      album_image_url: strack.album.images.first["url"],
      artist_name: strack.artists.first.name,
      preview_url: strack.preview_url,
      name: strack.name,
      decoy: true
    )
  end

  def generate_choices
    albums = [spotify_track.album]
    track_choices = albums.last.tracks.reject { |t| t.name == spotify_track.name }

    while track_choices.size < 4
      artist_albums = spotify_track.artists.first.albums

      albums << artist_albums.reject do |a|
        albums.any?(a)
      end.sample

      track_choices << albums.last.tracks.reject { |t| t.name == spotify_track.name }
      track_choices.flatten!
    end

    track_choices = track_choices.sample(4)

    track_choices.map! do |track|
      spotify_track_to_choice(track)
    end
    track_choices << to_choice

    track_choices.shuffle.each { |track| track.save! }
  end
end
