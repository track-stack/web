class RoundSerializer < ActiveModel::Serializer
  attributes :game_id, :turn_count

  def turn_count
    object.turns.count
  end
end