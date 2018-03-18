class StackSerializer
  include FastJsonapi::ObjectSerializer

  attributes :game_id
  attribute :winner { |obj| obj.winner }
  attribute :can_end { |obj| obj.can_end? }
  attribute :ended { |obj| obj.ended_at.present? }
  attribute :turns { |obj| obj.turns }
end
