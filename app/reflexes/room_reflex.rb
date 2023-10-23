class RoomReflex < ApplicationReflex
  def start_game
    room = Room.find_signed(element.dataset[:room_id])
    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    game = Game.create(room: room)
    PhaseChange.create(game: game, phase: :selection, end_time: Time.now + Room.track_selection_time)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "#room-header",
        html: render(RoomHeaderComponent.new(room: room))
      )
      .replace(
        selector: "#room-body",
        html: render(RoomBodyComponent.new(room: room, user: logged_user))
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
