class TurnSerializer < ActiveModel::Serializer
  attributes :user_id, :answer, :created_at
end
