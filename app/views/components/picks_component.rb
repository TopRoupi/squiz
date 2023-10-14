# frozen_string_literal: true

class PicksComponent < ApplicationComponent
  def initialize(game:, picked: nil, show_result: false)
    @game = game
    @next_track = @game.next_track
    @picked = picked
    @show_result = show_result
  end

  def template
    @next_track.choices.each_with_index do |choice, i|
      button(
        id: dom_id(choice, "button"),
        data: {
          reflex: "click->GameReflex#make_choice",
          choice_id: choice.signed_id
        },
        disabled: !@picked.nil?
      ) do
        "#{i} : #{choice.name} #{'picked' if @picked == choice}"
      end
      br
    end
  end
end
