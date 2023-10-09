# frozen_string_literal: true

class RoomBodyComponent < ApplicationComponent
  def initialize(room:, state: :waiting)
    @room = room
    # state: :waiting, :track_selection, guessing, guess_results
    @state = state
  end

  def template
    div id: "room-body" do
      case @state
      when :waiting
        plain ""
      when :track_selection
        render TrackSelectorComponent.new(room: @room)
      when :guessing
        p do
          plain "playing #{@room.next_track.spotify_track.preview_url} "
          div(data: {controller: "auto-play", auto_play_url_value: @room.next_track.spotify_track.preview_url}) {}
          @room.next_track.choices.each_with_index do |track, i|
            p { "#{i} : #{track.name}" }
          end
        end
      end
    end
  end
end
