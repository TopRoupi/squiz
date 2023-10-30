class Room < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :presences
  has_many :games

  has_many :users_presences, through: :presences, source: :user
  has_many :users_tracks, through: :tracks, source: :user

  def self.track_selection_time
    5.minutes
  end

  def self.track_guess_time
    35.seconds
  end

  def self.show_results_time
    20.seconds
  end

  def phase
    if current_game
      current_game.phase
    else
      :waiting
    end
  end

  def current_game
    games.where(finished: false).order(created_at: :ASC).last
  end

  def delete_track_selection_scheduled_jobs
    ss = Sidekiq::ScheduledSet.new
    room_end_trackselection_jobs = ss.select { |job| job["args"].first == id }
    room_end_trackselection_jobs.each(&:delete)
  end
end
