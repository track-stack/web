class TurnSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :user_id, :answer, :created_at, :match
  attribute :user_photo { |obj| obj.user_photo }
  attribute :has_exact_name_match { |obj| obj.has_exact_name_match? }
  attribute :has_exact_artist_match { |obj| obj.has_exact_artist_match? }
end
