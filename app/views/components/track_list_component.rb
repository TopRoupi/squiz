# frozen_string_literal: true

class TrackListComponent < ApplicationComponent
  def initialize(room:, tracks:, mode: nil)
    @room = room
    # @tracks = search.blank? ? [] : RSpotify::Track.search(search)
    @tracks = tracks
    # valid modes: :selector, :editor
    @mode = mode || :selector

    case @mode
    when :selector
      @button_action, @button_text = ["click->TrackSelectorReflex#select_music", "select"]
    when :editor
      @button_action, @button_text = ["click->TrackSelectorReflex#remove_music", "remove"]
    end
  end

  def selector?
    @mode == :selector
  end

  def template
    @tracks.reject { |t| t.preview_url.nil? }.each do |t|
      # img src: t.album.images.first
      div class: "flex p-2 mb-1 #{"bg-primary/20" unless selector?}" do
        img width: 50, height: 50, src: t.album.images.first["url"]
        div class: "ml-2" do
          p { t.name }
          p(class: "opacity-60") { t.artists.map(&:name).join(", ") }
        end
        button(
          class: "ml-auto btn btn-ghost",
          data: {
            reflex: @button_action, track_id: t.id, room_id: @room.signed_id
          }
        ) { @button_text }
      end
    end
  end
end
