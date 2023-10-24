class Game < ApplicationRecord
  belongs_to :room
  has_many :tracks
  has_many :phase_changes # TODO add validation to invalidate rooms without a phase

  def auto_correct_phase
    if phase == :selection && current_phase.seconds_to_end <= 0
      if next_track
        change_current_phase_to(:guessing)
      else
        change_current_phase_to(:finished)
      end
    end
  end

  def change_current_phase_to(phase)
    valid_phases = PhaseChange.phases.keys.map(&:to_sym)
    raise "phase not in #{valid_phases}" unless valid_phases.any?(phase)

    kwargs = {game: self, phase: phase}

    case phase
    when :selection
      kwargs[:end_time] = Time.now + Room.track_selection_time
    when :guessing
      kwargs[:end_time] = Time.now + Room.track_guess_time
    end

    PhaseChange.create(**kwargs)
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
