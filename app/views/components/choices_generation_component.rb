class ChoicesGenerationComponent < ApplicationComponent
  def initialize(game:)
    @to_generate = game.tracks.count
    @generated = game.tracks.count do |track|
      track.choices.size == 5
    end
  end

  def template
    p { "#{@generated} out of #{@to_generate}" }
  end
end
