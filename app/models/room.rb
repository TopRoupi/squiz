class Room < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :presences
  has_many :tracks

  has_many :users_presences, through: :presences, source: :user
  has_many :users_tracks, through: :tracks, source: :user

  def next_track
    tracks.order("created_at ASC").last
  end
end
