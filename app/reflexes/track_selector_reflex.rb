# frozen_string_literal: true

class TrackSelectorReflex < ApplicationReflex
  def search
    search = element.value
    room = Room.find_signed(element.dataset[:room_id])
    tracks = Track.search_spotify_tracks(search)

    morph "#tracks", render(TrackListComponent.new(room: room, tracks: tracks))
  end

  def select_music
    room = Room.find_signed(element.dataset[:room_id])

    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    track_id = element.dataset[:track_id]

    if logged_user.has_track_on_game?(track_id: track_id, game: room.current_game)
      morph "#track-selector-errors", "you already selected this track"
      return
    end

    if logged_user.count_selected_tracks_on_game(room.current_game) + 1 > room.current_game.tracks_limit
      morph "#track-selector-errors", "you cant add more tracks"
      return
    end

    track = Track.new(game: room.current_game, track_id: track_id, user: logged_user)
    if track.spotify_track.preview_url.nil?
      morph "#track-selector-errors", "music not registered, no preview_url available"
      return
    else
      track.save
    end

    selected_tracks = logged_user.selected_tracks_on_game(room.current_game)

    morph "#track-selector-errors", ""
    morph "#selected-tracks", render(TrackListComponent.new(room: room, tracks: selected_tracks, mode: :editor))

    cable_ready[ApplicationChannel]
      .morph(
        selector: "#players-tracks",
        children_only: true,
        html: render(PlayersSelectedTracksComponent.new(game: room.current_game))
      )
      .broadcast_to(stream_id)
  end

  def remove_music
    room = Room.find_signed(element.dataset[:room_id])
    track_id = element.dataset[:track_id]

    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    room.current_game.tracks.where(user: logged_user, track_id: track_id).delete_all

    selected_tracks = logged_user.selected_tracks_on_game(room.current_game)
    morph "#selected-tracks", render(TrackListComponent.new(room: room, tracks: selected_tracks, mode: :editor))

    cable_ready[ApplicationChannel]
      .morph(
        selector: "#players-tracks",
        children_only: true,
        html: render(PlayersSelectedTracksComponent.new(game: room.current_game))
      )
      .broadcast_to(stream_id)
  end
end
