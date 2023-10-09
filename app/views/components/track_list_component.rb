# frozen_string_literal: true

class TrackListComponent < ApplicationComponent
  def initialize(room:, search:)
    @room = room
    @tracks = search.blank? ? [] : RSpotify::Track.search(search)
  end

  def template
    @tracks.each do |t|
      # img src: t.album.images.first
      div class: "flex" do
        img width: 50, height: 50, src: t.album.images.first["url"]
        plain t.name
        plain " | " + t.artists.first.name
        button(data: {reflex: "click->TrackSelectorReflex#select_music", track_id: t.id, room_id: @room.signed_id}) { "select" }
      end
    end
  end
end
