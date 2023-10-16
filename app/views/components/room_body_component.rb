# frozen_string_literal: true

class RoomBodyComponent < ApplicationComponent
  def initialize(room:, user: nil, state: :waiting)
    @room = room
    @game = room.current_game
    @next_track = @game.next_track
    # state: :waiting, :track_selection, guessing, guess_results
    @state = state
    @user = user
  end

  def template
    div class: "border-solid border-2 border-gray-900 p-2 mb-2", id: "room-body" do
      case @state
      when :waiting
        plain ""
      when :track_selection
        render TrackSelectorComponent.new(room: @room, user: @user)
      when :guessing
        p do
          div(
            class: "mb-4 w-full",
            data: {controller: "auto-play", auto_play_url_value: @next_track.spotify_track.preview_url}
          ) {}
          div(id: dom_id(@game, "picks")) do
            render(PicksComponent.new(game: @game))
          end
        end
      end
    end
  end
end
