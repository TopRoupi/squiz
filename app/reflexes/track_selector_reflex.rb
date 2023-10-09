# frozen_string_literal: true

class TrackSelectorReflex < ApplicationReflex
  def search
    search = element.value
    room = Room.find_signed(element.dataset[:room_id])

    morph "#tracks", render(TrackListComponent.new(room: room, search: search))
  end

  def select_music
    room = Room.find_signed(element.dataset[:room_id])
    track_id = element.dataset[:track_id]

    Track.create(room: room, track_id: track_id, user: logged_user)

    morph :nothing
  end
end
