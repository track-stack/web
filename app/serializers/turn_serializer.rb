class TurnSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :user_id, :answer, :created_at, :match

  attribute :user_photo do |object|
    object.user.image
  end

  attribute :has_exact_name_match do |object|
    object.has_exact_name_match?
  end

  attribute :has_exact_artist_match do |object|
    object.has_exact_artist_match?
  end
end
