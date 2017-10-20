class GameInvite < ApplicationRecord
  scope :pending, -> { where(status: 0) }
  scope :accepted, -> { where(status: 1) }

  def accept!
    update_attributes!(status: 1)
  end

  def pending?
    status == 0
  end

  def accepted?
    status == 1
  end
end
