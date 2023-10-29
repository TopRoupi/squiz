class PhaseChange < ApplicationRecord
  belongs_to :game
  enum :phase, [:selection, :generation, :guessing, :finished]

  def seconds_to_end
    end_time - DateTime.now
  end
end
