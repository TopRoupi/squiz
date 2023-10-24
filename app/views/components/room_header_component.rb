# frozen_string_literal: true

class RoomHeaderComponent < ApplicationComponent
  def initialize(room:)
    @room = room
    # state: :waiting, :selection, guessing, guess_results
    @state = @room.phase
  end

  def template
    div class: "flex border-solid border-2 border-gray-900 p-2 mb-2", id: "room-header" do
      case @state
      when :waiting, :finished
        p { "waiting players" }
        if @room.owner == helpers.logged_user
          div class: "ml-auto", id: "start-button" do
            button(
              class: "btn",
              data: {reflex: "click->RoomReflex#start_game"}
            ) { "start game" }
          end
        end
      when :selection
        span class: "font-semibold mr-2" do
          "select your tracks"
        end
        span { "game is starting in " }
        span(
          class: "font-semibold ml-2",
          data: {
            controller: "timer",
            timer_duration_value: @room.current_game.current_phase.seconds_to_end,
            timer_callback_reflex_value: "RoomReflex#finish_track_selection"
          }
        ) { "" }

        if @room.owner == helpers.logged_user
          button(
            class: "btn ml-auto",
            data: {reflex: "click->RoomReflex#finish_track_selection"}
          ) { "finish track selection" }
        end
      when :guessing
        div do
          plain "time to pick "
          span(
            data: {
              controller: "timer",
              timer_duration_value: Room.show_results_time.seconds.to_i,
              timer_callback_reflex_value: "RoomReflex#show_results"
            }
          ) { "" }
        end
        div class: "ml-auto" do
          plain "time to next round "
          span(
            data: {
              controller: "timer",
              timer_duration_value: 30,
              timer_callback_reflex_value: "RoomReflex#advance_turn"
            }
          ) { "" }
        end
      end
    end
  end
end
