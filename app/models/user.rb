class User < ApplicationRecord
  has_many :picks
  has_many :users, through: :picks

  def points_on_room(room)
    Choice.joins(picks: [:user], track: [game: [:room]]).where("rooms.id = ? and choices.decoy = false and users.id = ?", room.id, id).count * 100
  end

  def selected_tracks_on_game(game)
    game.tracks.where(user: self).to_a.map(&:spotify_track)
  end

  def make_choice(choice)
    Choice.where(track_id: choice.track_id).each do |c|
      c.picks.where(user: self).destroy_all
    end
    Pick.create(choice: choice, user: self)
  end
end
