class GameInvitation < ApplicationRecord
  enum status: [:pending, :accepted]

  scope :pending, -> { where(status: 0) }
  scope :accepted, -> { where(status: 1) }
end
