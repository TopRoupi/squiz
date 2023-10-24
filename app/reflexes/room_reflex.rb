class RoomReflex < ApplicationReflex
  def start_game
    morph :nothing

    room = Room.find(request.params[:id])
    return if logged_user != room.owner

    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    game = Game.create(room: room)
    game.change_current_phase_to(:selection)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "#room-header",
        html: render(RoomHeaderComponent.new(room: room))
      )
      .replace(
        selector: "#room-body",
        html: render(RoomBodyComponent.new(room: room))
      )
      .broadcast_to(stream_id)
  end

  def finish_track_selection
    morph :nothing

    room = Room.find(request.params[:id])
    return if logged_user != room.owner

    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    room.current_game.change_current_phase_to(:guessing)

    GenerateGameTracksChoicesJob.perform_inline(room.current_game.id)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "#room-header",
        html: render(RoomHeaderComponent.new(room: room))
      )
      .replace(
        selector: "#room-body",
        html: render(RoomBodyComponent.new(room: room))
      )
      .broadcast_to(stream_id)
  end

  def show_results
    morph :nothing

    room = Room.find(request.params[:id])
    return if logged_user != room.owner

    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    result_choice = room.current_game.next_track.choices.where(decoy: false).last

    cable_ready[ApplicationChannel]
      .set_attribute(
        selector: dom_id(room.current_game.next_track, "choices"),
        name: "data-picks-result-value",
        value: result_choice.id
      )
      .broadcast_to(stream_id)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "##{room_dom_id}",
        html: render(
          RoomPlayerPresenceComponent.new(room: room),
          layout: false
        )
      )
      .broadcast_to(stream_id)
  end

  def advance_turn
    morph :nothing

    room = Room.find(request.params[:id])
    return if logged_user != room.owner

    room_dom_id = dom_id(room)[1..]
    stream_id = Cable.signed_stream_name(room_dom_id)

    room.current_game.next_track.update!(guessed: true)

    if room.current_game.next_track.nil?
      room.current_game.change_current_phase_to(:finished)
    end

    cable_ready[ApplicationChannel]
      .replace(
        selector: "#room-header",
        html: render(RoomHeaderComponent.new(room: room))
      )
      .replace(
        selector: "#room-body",
        html: render(RoomBodyComponent.new(room: room))
      )
      .broadcast_to(stream_id)
  end
end
