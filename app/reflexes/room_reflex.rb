class RoomReflex < ApplicationReflex
  def start_game
    room = Room.find_signed(element.dataset[:room_id])
    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    room.delete_track_selection_scheduled_jobs

    EndTrackSelectionJob.perform_in(Room.track_selection_time, room.id)

    Game.create(room: room)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "#room-header",
        html: render(RoomHeaderComponent.new(room: room, state: :track_selection))
      )
      .replace(
        selector: "#room-body",
        html: render(RoomBodyComponent.new(room: room, user: logged_user, state: :track_selection))
      )
      .broadcast_to(stream_id)
    morph :nothing
  end

  def finish_track_selection
    room = Room.find_signed(element.dataset[:room_id])
    room.delete_track_selection_scheduled_jobs
    EndTrackSelectionJob.perform_async(room.id)
    morph :nothing
  end
end
