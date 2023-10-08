class Presence < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ActionView::RecordIdentifier
  include CableReady::Broadcaster

  belongs_to :room
  belongs_to :user

  after_commit :update_room_player_presence
  after_destroy :update_room_player_presence

  private

  def update_room_player_presence
    room_dom_id = dom_id(room)[1..-1]
    stream_id = Cable.signed_stream_name(room_dom_id)

    cable_ready[ApplicationChannel]
      .replace(
        selector: "##{room_dom_id}",
        html: rendered_room_presence
      )
      .broadcast_to(stream_id)
  end

  def rendered_room_presence
    ApplicationController.renderer.render(
      RoomPlayerPresenceComponent.new(room: room),
      layout: false
    )
  end
end
