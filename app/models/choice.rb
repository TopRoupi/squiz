class Choice < ApplicationRecord
  belongs_to :track
  has_many :picks
end
