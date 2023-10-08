class Room < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :presences

  has_many :users_presences, through: :presences, source: :user
end
