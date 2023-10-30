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
    div class: "card bg-neutral text-neutral-content p-2 rounded-md mt-2" do
      h1(class: "text-center mb-2") { "TrackSelector" }
      div id: "track-selector-errors", class: "text-red-900 font-bold bg-yellow-200" do
      end
      input(
        class: "input input-bordered input-sm w-full mb-2",
        placeholder: "search",
        value: @search,
        data_reflex: "debounced:input->TrackSelectorReflex#search",
        data_room_id: @room.signed_id
      )

      div id: "selected-tracks" do
        render TrackListComponent.new(room: @room, tracks: @selected_tracks, mode: :editor)
      end

      div id: "tracks" do
        render TrackListComponent.new(room: @room, tracks: @tracks)
      end
    end
  end
end
