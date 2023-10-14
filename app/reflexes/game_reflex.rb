# frozen_string_literal: true

class GameReflex < ApplicationReflex
  def make_choice
    choice = Choice.find_signed(element.dataset[:choice_id])
    game = choice.track.game
    logged_user.make_choice(choice)

    # cable_ready
    #   .append(
    #     selector: dom_id(choice, "button"),
    #     html: " picked"
    #   )
    #   .broadcast

    # morph :nothing

    morph dom_id(game, "picks"), render(PicksComponent.new(game: game, picked: choice))
  end
end
