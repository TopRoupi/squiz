class Game < ApplicationRecord
  belongs_to :room
  has_many :tracks
  has_many :phase_changes # TODO add validation to invalidate rooms without a phase

  def change_current_phase_to(phase)
    PhaseChange.create(game: self, phase: phase)
  end

  def current_phase
    phase_changes.order("created_at ASC").last
  end

  def phase
    phase_changes.order("created_at ASC").last.phase.to_sym
  end

  def next_track
    tracks.where(guessed: false).order("created_at ASC").last
  end
end
