# frozen_string_literal: true

class RoomBodyComponent < ApplicationComponent
  def initialize(room:, user: nil)
    @room = room
    @game = room.current_game
    @next_track = @game&.next_track
    # state: :waiting, :selection, guessing
    @state = @room.phase
    @user = user
  end

  def template
    div class: "border-solid border-2 border-gray-900 p-2 mb-2", id: "room-body" do
      case @state
      when :waiting
        plain ""
      when :selection
        render TrackSelectorComponent.new(room: @room, user: @user)
      when :guessing
        p do
          div(
            class: "mb-4 w-full hidden",
            data: {
              controller: "auto-play",
              auto_play_url_value: @next_track.spotify_track.preview_url
            }
          ) {}
          div(id: dom_id(@game, "picks")) do
            render(PicksComponent.new(game: @game))
          end
        end
      end
    end
  end
end
