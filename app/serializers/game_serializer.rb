class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :players

  has_many :stacks

  def players
    user_games = UserGame.includes(:user).where(game_id: object.id)
    viewer_user_game = user_games.detect { |user_game| user_game.user_id == viewer_id.to_i }
    opponent_user_game = (user_games - [viewer_user_game]).first

    # TODO: Where to put this
    winners = object.stacks.map(&:winner).compact
    grouped = winners.group_by(&:user_id)
    keys = grouped.keys
    keys.each do |key|
      value = grouped[key]
      grouped[key] = value.reduce(0) { |sum, val| val.score + sum }
    end

    {
      viewer: UserSerializer.new(viewer_user_game.user, score: grouped[viewer_id]),
      opponent: UserSerializer.new(opponent_user_game.user, score: grouped[opponent_user_game.user_id])
    }
  end

  private

  def viewer_id
    @instance_options[:viewer].try(:id)
  end
end
