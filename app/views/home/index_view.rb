# frozen_string_literal: true

class Home::IndexView < ApplicationView
  def template
    render TrackSelectorComponent.new
  end
end
