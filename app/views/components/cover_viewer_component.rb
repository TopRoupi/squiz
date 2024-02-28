# frozen_string_literal: true

class CoverViewerComponent < ApplicationComponent
  def initialize(track:, hide: true)
    @track = track
    @hide = hide
    @strack = track.spotify_track
  end

  def hide?
    @hide == true
  end

  def template
    div class: "flex text-9xl text-white m-auto mt-2 mb-1", style: "max-width: 200px; height: 200px; background-color: black;" do
      if hide?
        span(class: "block m-auto w-fit") { "?" }
      else
        img class: "w-full", src: @strack.album.images.first["url"]
      end
    end
    div(class: "flex justify-center mb-6 font-semibold text-2xl") {
      if hide?
        span { "?????????????????" }
      else
        a(
          class: "link",
          target: "_blank",
          href: "https://open.spotify.com/track/#{@strack.id}"
        ) {
          plain @strack.name
        }
      end
    }
  end
end
