class RoundSerializer < ActiveModel::Serializer
  attributes :game_id

  has_many :turns
end
