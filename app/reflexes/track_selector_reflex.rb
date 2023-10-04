# frozen_string_literal: true

class TrackSelectorReflex < ApplicationReflex
  def search
    search = element.value

    morph "#tracks", render(TrackListComponent.new(search: search))
    # morph :nothing
    # cable_ready.replace(selector: "#track-selector", html: render(TrackSelectorComponent.new(search: search)))
  end
end
