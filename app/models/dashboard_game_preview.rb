class DashboardGamePreview
  attr_reader :game

  def initialize(viewer:, game:)
    @viewer = viewer
    @game = game
  end

  # this exists bc the game is currently 2 player only
  def opponent
    opponents.first
  end

  def viewers_turn?
    return @viewers_turn if defined?(@viewers_turned)
    last_turn_user_id = game.turns.last.user_id
    @viewers_turn = last_turn_user_id != viewer.id && last_turn_user_id != User.bot.id
  end

  def id
    SecureRandom.hex
  end

  def updated_at
    @game.updated_at
  end

  private

  def opponents
    @opponents ||= game.players.reject { |player| player == viewer }
  end

  attr_reader :viewer
end

