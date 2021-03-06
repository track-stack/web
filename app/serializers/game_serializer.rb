# Serializes an instance of Serializable::Game

class GameSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :status
  attribute :players { |obj| obj.players }
  attribute :stacks { |obj| obj.stacks }
  attribute :viewers_turn { |obj| obj.viewers_turn? }
end
