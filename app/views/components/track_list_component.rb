# frozen_string_literal: true

class TrackListComponent < ApplicationComponent
  def initialize(room:, tracks:, mode: nil)
    @room = room
    # @tracks = search.blank? ? [] : RSpotify::Track.search(search)
    @tracks = tracks
    # valid modes: :selector, :editor
    @mode = mode || :selector
  end

  def template
    @tracks.each do |t|
      # img src: t.album.images.first
      div class: "flex" do
        img width: 50, height: 50, src: t.album.images.first["url"]
        plain t.name
        plain " | " + t.artists.first.name
        case @mode
        when :selector
          button(data: {reflex: "click->TrackSelectorReflex#select_music", track_id: t.id, room_id: @room.signed_id}) { "select" }
        when :editor
          button(data: {reflex: "click->TrackSelectorReflex#remove_music", track_id: t.id, room_id: @room.signed_id}) { "remove" }
        end
      end
    end
  end
end
