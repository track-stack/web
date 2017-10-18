class GameInvite < ApplicationRecord
  scope :pending, -> { where(status: 0) }
  scope :accepted, -> { where(status: 1) }

  def accept!
    update_attributes!(status: 1)
  end
end