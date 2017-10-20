class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :players

  def players
    viewer_id = @instance_options[:current_user_id]
    user_games = UserGame.includes(:user).where(game_id: object.id)
    viewer_user_game = user_games.detect { |user_game| user_game.user_id == viewer_id.to_i }
    opponent_user_game = (user_games. - [viewer_user_game]).first

    {
      viewer: UserSerializer.new(viewer_user_game.user),
      opponent: UserSerializer.new(opponent_user_game.user)
    }
  end
end
