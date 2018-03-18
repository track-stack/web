module Serializable
  class Game
    delegate :id, :status, :stacks, to: :game

    def initialize(game:, viewer:)
      @game = game
      @viewer = viewer
    end

    def players
      user_games = UserGame.includes(:user).where(game_id: game.id)
      viewer_user_game = user_games.detect { |user_game| user_game.user_id == viewer.id.to_i }
      opponent_user_game = (user_games - [viewer_user_game]).first

      # TODO: Where to put this
      winners = game.stacks.map(&:winner).compact
      grouped = winners.group_by(&:user_id)
      keys = grouped.keys
      keys.each do |key|
        value = grouped[key]
        grouped[key] = value.reduce(0) { |sum, val| val.score + sum }
      end

      {
        viewer: UserSerializer.new(viewer_user_game.user).to_hash.merge(score: grouped[viewer.id]),
        opponent: UserSerializer.new(opponent_user_game.user).to_hash.merge(score: grouped[opponent_user_game.user_id])
      }
    end

    private

    attr_reader :game, :viewer
  end
end
