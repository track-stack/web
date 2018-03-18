# Serializes an instance of Serializable::Stack

class StackSerializer
  include FastJsonapi::ObjectSerializer

  attributes :game_id
  attribute :winner { |obj| obj.winner }
  attribute :can_end { |obj| obj.can_end? }
  attribute :ended { |obj| obj.ended? }
  attribute :turns { |obj| obj.turns }
end
