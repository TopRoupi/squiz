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
    div class: "card bg-base-100 rounded-t-none border-2 border-base-200 p-5 mb-2", id: "room-body" do
      case @state
      when :waiting
        plain ""
      when :selection
        div id: "players-tracks" do
          render PlayersSelectedTracksComponent.new(game: @game)
        end
        render TrackSelectorComponent.new(room: @room, user: @user)
      when :generation
        div id: "choices-generation" do
          render ChoicesGenerationComponent.new(game: @game)
        end
      when :guessing
        div do
          div(id: "track_album") do
            render(CoverViewerComponent.new(track: @next_track))
          end

          div(id: dom_id(@game, "picks")) do
            render(PicksComponent.new(game: @game))
          end

          div(
            class: "mb-4 mt-6 w-full",
            data: {
              controller: "auto-play",
              auto_play_url_value: @next_track.spotify_track.preview_url
            }
          ) {}
        end
      end
    end
  end
end
