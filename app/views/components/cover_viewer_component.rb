# frozen_string_literal: true

class CoverViewerComponent < ApplicationComponent
  def initialize(track:, hide: true)
    @track = track
    @hide = hide
  end

  def hide?
    @hide == true
  end

  def template
    div class: "flex text-9xl text-white m-auto mt-2 mb-6", style: "max-width: 200px; height: 200px; background-color: black;" do
      if hide?
        span(class: "block m-auto w-fit") { "?" }
      else
        img class: "w-full", src: @track.spotify_track.album.images.first["url"]
      end
    end
  end
end
