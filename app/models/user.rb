class User < ApplicationRecord
  has_many :picks
  has_many :users, through: :picks

  def points_on_room(room)
    picks
      .joins(:user, choice: [game: [:room]])
      .where("rooms.id = ? and choices.decoy = false and picks.user_id = ?", room.id, id)
      .select(:score)
      .map(&:score)
      .sum
  end

  def last_score_on_room(room)
    score = picks
      .joins(:user, choice: [game: [:room]])
      .where("rooms.id = ? and choices.decoy = false and picks.user_id = ?", room.id, id)
      .order("created_at ASC")
      .last
      &.score
    score ||= 0
  end

  def selected_tracks_on_game(game)
    game.tracks.where(user: self).to_a.map(&:spotify_track)
  end

  def make_choice(choice)
    Choice.where(track_id: choice.track_id).each do |c|
      c.picks.where(user: self).destroy_all
    end

    score = 0
    seconds_to_pick = (Time.now - choice.game.current_phase.created_at).seconds.to_i

    if choice.decoy == false
      base_points = 100
      base_time_points = 100

      time_bonus_points = 0
      if seconds_to_pick < Room.show_results_time.to_i
        time_bonus_points = base_time_points * ((Room.show_results_time.to_i - seconds_to_pick) / Room.show_results_time.to_f)
        time_bonus_points.ceil
      end

      score = base_points + time_bonus_points
    end

    Pick.create(choice: choice, user: self, score: score, seconds: seconds_to_pick)
  end
end
