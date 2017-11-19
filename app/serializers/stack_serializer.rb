class StackSerializer < ActiveModel::Serializer
  attributes :can_end, :game_id, :ended, :winner

  has_many :turns

  def winner
    object.winner
  end

  def can_end
    object.can_end?
  end

  def ended
    object.ended_at.present?
  end
end
