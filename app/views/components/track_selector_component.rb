# frozen_string_literal: true

class TrackSelectorComponent < ApplicationComponent
  def initialize(room:, user: nil, search: "")
    @room = room
    @search = search
    @user = user

    @tracks = Track.search_spotify_tracks(search)

    @selected_tracks = user&.selected_tracks_on_game(room.current_game)
    @selected_tracks ||= []
  end

  def template
    div id: "track-selector-errors", class: "text-red-900 font-bold bg-yellow-200" do
    end
    p { "your selected tracks for this match" }
    div id: "selected-tracks" do
      render TrackListComponent.new(room: @room, tracks: @selected_tracks, mode: :editor)
    end
    h1 { "TrackSelector" }
    span { "search" }
    input(
      class: "border-solid border-2 border-black ml-2",
      value: @search,
      data_reflex: "debounced:input->TrackSelectorReflex#search",
      data_room_id: @room.signed_id
    )

    div id: "tracks" do
      render TrackListComponent.new(room: @room, tracks: @tracks)
    end
  end
end
