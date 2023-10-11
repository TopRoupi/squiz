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
    track_id = element.dataset[:track_id]

    Track.create(room: room, track_id: track_id, user: logged_user)

    selected_tracks = logged_user.selected_tracks_on_room(room)
    morph "#selected-tracks", render(TrackListComponent.new(room: room, tracks: selected_tracks, mode: :editor))
  end

  def remove_music
    room = Room.find_signed(element.dataset[:room_id])
    track_id = element.dataset[:track_id]

    room.tracks.where(user: logged_user, track_id: track_id).delete_all

    selected_tracks = logged_user.selected_tracks_on_room(room)
    morph "#selected-tracks", render(TrackListComponent.new(room: room, tracks: selected_tracks, mode: :editor))
  end
end
