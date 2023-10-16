# frozen_string_literal: true

class PicksComponent < ApplicationComponent
  def initialize(game:, picked: nil, show_result: false)
    @game = game
    @next_track = @game.next_track
    @picked = picked
    @show_result = show_result
  end

  def template
    div(
      id: dom_id(@next_track, "choices"),
      data: {
        controller: "picks"
      }
    ) do
      @next_track.choices.each_with_index do |choice, i|
        button(
          id: choice.id,
          data: {
            reflex: "click->GameReflex#make_choice",
            choice_id: choice.signed_id,
            picks_target: "choice"
          }
        ) do
          "#{i} : #{choice.name}"
        end
        br
      end
    end
  end
end
