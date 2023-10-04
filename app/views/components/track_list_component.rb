# frozen_string_literal: true

class TrackListComponent < ApplicationComponent
  def initialize(search:)
    @tracks = search.blank? ? [] : RSpotify::Track.search(search)
  end

  def template
    @tracks.each do |t|
      # img src: t.album.images.first
      div class: "flex" do
        img width: 50, height: 50, src: t.album.images.first["url"]
        plain t.name
        plain " | " + t.artists.first.name
      end
    end
  end
end
