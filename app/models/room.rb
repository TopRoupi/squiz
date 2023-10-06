class Room < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :presences
end
