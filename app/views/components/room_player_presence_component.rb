# frozen_string_literal: true

class RoomPlayerPresenceComponent < ApplicationComponent
  def initialize(room:)
    @room = room
    @players = @room.users_presences
  end

  def template
    div(
      id: dom_id(@room),
      class: "card bg-base-200 px-5 py-4 mb-2"
    ) do
      div class: "flex justify-between" do
        div do
          h2 class: "font-semibold" do
            "Players"
          end

          @players.each_with_index do |user, i|
            last_score = user.last_score_on_room(@room)
            div class: "flex" do
              plain "#{i + 1}. #{user.name}"
              if last_score
                case last_score
                when 0
                  div(class: "badge badge-error") { user.last_score_on_room(@room) }
                else
                  div(class: "badge badge-primary") { user.last_score_on_room(@room) }
                end
              end
            end
          end
        end

        div do
          h2 class: "font-semibold text-center" do
            "Scores"
          end

          @players.each do |user|
            div class: "text-center" do
              plain user.points_on_room(@room)
            end
          end
        end
      end
    end
  end
end
