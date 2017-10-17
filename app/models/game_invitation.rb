class GameInvitation < ApplicationRecord
  enum status: [:pending, :accepted]

  def accept
    update_attribute(:status, 1)
  end
end
