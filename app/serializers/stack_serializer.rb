class StackSerializer < ActiveModel::Serializer
  attributes :can_end, :game_id

  has_many :turns

  def can_end
    object.can_end?
  end
end
