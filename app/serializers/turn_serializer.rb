class TurnSerializer < ActiveModel::Serializer
  attributes :user_id, :answer, :created_at, :user_photo, :match, :has_exact_name_match, :has_exact_artist_match

  def user_photo
    object.user.image
  end

  def has_exact_name_match
    object.has_exact_name_match?
  end

  def has_exact_artist_match
    object.has_exact_artist_match?
  end
end
