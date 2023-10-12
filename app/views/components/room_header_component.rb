# frozen_string_literal: true

class RoomHeaderComponent < ApplicationComponent
  def initialize(room:, state: :waiting)
    @room = room
    # state: :waiting, :track_selection, guessing, guess_results
    @state = state
  end

  def template
    div id: "room-header" do
      case @state
      when :waiting
        if @room.owner == helpers.logged_user
          div id: "start-button" do
            button(data: {reflex: "click->RoomReflex#start_game", room_id: @room.signed_id}) { "start game" }
          end
        end

        p { "waiting players" }
      when :track_selection
        p do
          plain "game is starting in "
          plain " | select your tracks "
          span(data: {controller: "timer", timer_duration_value: Room.track_selection_time.seconds.to_i}) { "" }

          if @room.owner == helpers.logged_user
            p do
              button(data: {reflex: "click->RoomReflex#finish_track_selection", room_id: @room.signed_id}) { "finish track selection" }
            end
          end
        end
      when :guessing
        p do
          plain "guessing #{@room.next_track.track_id} "
          span(data: {controller: "timer", timer_duration_value: 30}) { "" }
        end
      end
    end
  end
end
