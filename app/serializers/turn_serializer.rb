class TurnSerializer < ActiveModel::Serializer
  attributes :user_id, :answer, :created_at, :user_photo

  def user_photo
    object.user.image # N + 1 (cached lookup)
  end
end
