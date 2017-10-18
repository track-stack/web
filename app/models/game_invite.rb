class GameInvite < ApplicationRecord
  scope :pending, -> { where(status: 0) }
  scope :accepted, -> { where(status: 1) }

  def accept
    update_attribute(:status, 1)
  end
end
