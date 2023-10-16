# frozen_string_literal: true

class GameReflex < ApplicationReflex
  def make_choice
    choice = Choice.find_signed(element.dataset[:choice_id])
    track = choice.track
    logged_user.make_choice(choice)

    cable_ready
      .set_attribute(
        selector: dom_id(track, "choices"),
        name: "data-picks-picked-value",
        value: choice.id
      )
      .set_attribute(
        selector: dom_id(track, "choices"),
        name: "data-picks-disabled-value",
        value: true
      )
      .broadcast

    morph :nothing

    # morph dom_id(game, "picks"), render(PicksComponent.new(game: game, picked: choice))
  end
end
