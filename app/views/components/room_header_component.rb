# frozen_string_literal: true

class RoomHeaderComponent < ApplicationComponent
  def initialize(room:)
    @room = room
    # state: :waiting, :selection, guessing, guess_results
    @state = @room.phase
  end

  def template
    div class: "card bg-base-200 items-center flex flex-row px-4 py-2 rounded-b-none", id: "room-header" do
      case @state
      when :waiting, :finished
        span(class: "font-semibold") { "waiting players" }
        if @room.owner == helpers.logged_user
          div class: "ml-auto", id: "start-button" do
            button(
              class: "btn btn-primary btn-sm",
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
            class: "btn btn-primary btn-sm ml-auto",
            data: {reflex: "click->RoomReflex#finish_track_selection"}
          ) { "finish track selection" }
        end
      when :generation
        span { "generating random choices for each track" }
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
              timer_duration_value: Room.track_guess_time.seconds.to_i,
              timer_callback_reflex_value: "RoomReflex#advance_turn"
            }
          ) { "" }
        end
      end
    end
  end
end
