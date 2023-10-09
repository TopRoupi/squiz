class RoomReflex < ApplicationReflex
  def start_game
    room = Room.find_signed(element.dataset[:room_id])

    room_dom_id = dom_id(room)[1..-1]
    stream_id = Cable.signed_stream_name(room_dom_id)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "#room-header",
        html: "game is starting in 5:00 | select your tracks"
      )
      .remove(selector: "#start-button")
      .broadcast_to(stream_id)
    morph :nothing
  end
end
