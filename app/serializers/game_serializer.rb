class GameSerializer < ActiveModel::Serializer
  attributes :id, :players

  has_many :users

  def players
    user_games = UserGame.includes(:user).where(game_id: object.id)
    { player_1: user_games.first.user, player_2: user_games.last.user }
  end
end
