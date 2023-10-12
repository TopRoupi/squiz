class Room < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :presences
  has_many :tracks

  has_many :users_presences, through: :presences, source: :user
  has_many :users_tracks, through: :tracks, source: :user

  def self.track_selection_time
    5.minutes
  end

  def delete_track_selection_scheduled_jobs
    ss = Sidekiq::ScheduledSet.new
    room_end_trackselection_jobs = ss.select { |job| job["args"].first == id }
    room_end_trackselection_jobs.each(&:delete)
  end

  def next_track
    tracks.order("created_at ASC").last
  end
end
