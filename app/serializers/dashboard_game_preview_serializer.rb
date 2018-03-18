# Serializes an instance of DashboardGamePreview

class DashboardGamePreviewSerializer
  include FastJsonapi::ObjectSerializer

  attribute :viewers_turn { |obj| obj.viewers_turn }
  attribute :status { |obj| obj.game.status }
  attribute :game_id { |obj| obj.game.id }

  attribute :opponent do |object|
    hash = UserSerializer.new(object.opponent).to_hash
    hash[:data][:attributes]
  end
end

