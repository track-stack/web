class GameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status
  attribute :players do |object|
    object.players
  end

  attribute :stacks do |object|
    object.stacks
  end
end
