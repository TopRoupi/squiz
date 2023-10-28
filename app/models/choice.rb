class Choice < ApplicationRecord
  belongs_to :track
  has_one :game, through: :track
  has_many :picks
end
