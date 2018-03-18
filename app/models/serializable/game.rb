module Serializable
  class Game
    delegate :id, :status, to: :game

    def initialize(game:, viewer:)
      @game = game
      @viewer = viewer
    end

    def players
      scores = scores_by_user_id
      opponent = (game.players - [viewer]).first

      viewer_hash = UserSerializer.new(viewer).to_hash
      viewer_attrs = viewer_hash[:data][:attributes]
      opponent_hash = UserSerializer.new(opponent).to_hash
      opponent_attrs = opponent_hash[:data][:attributes]

      {
        viewer: viewer_attrs.merge(score: scores[viewer.id]),
        opponent: opponent_attrs.merge(score: scores[opponent.id])
      }
    end

    def stacks
      game.stacks.map do |stack|
        serializable = Serializable::Stack.new(stack)
        hash = StackSerializer.new(serializable).to_hash
        hash[:data][:attributes]
      end
    end

    private

    def scores_by_user_id
      winners = game.stacks.map(&:winner).compact
      grouped = winners.group_by(&:user_id)
      user_ids = grouped.keys
      user_ids.each do |user_id|
        stacks = grouped[user_id]
        grouped[user_id] = stacks.reduce(0) { |sum, stack| stack.score + sum }
      end
      grouped
    end

    attr_reader :game, :viewer
  end
end
