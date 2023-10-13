class Game < ApplicationRecord
  belongs_to :room
  has_many :tracks

  def next_track
    tracks.where(guessed: false).order("created_at ASC").last
  end
end
