class StackSerializer < ActiveModel::Serializer
  attributes :can_end, :game_id, :ended

  has_many :turns
  has_many :stack_winners

  def can_end
    object.can_end?
  end

  def ended
    object.ended_at.present?
  end
end
