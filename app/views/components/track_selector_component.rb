# frozen_string_literal: true

class TrackSelectorComponent < ApplicationComponent
  def initialize(search: "")
    @search = search
  end

  def template
    h1 { "TrackSelector" }
    span { "search" }
    input(
      class: "border-solid border-2 border-black ml-2",
      value: @search,
      data_reflex: "debounced:input->TrackSelectorReflex#search"
    )

    div id: "tracks" do
      render TrackListComponent.new(search: @search)
    end
  end
end
