class DashboardGamePreview
  def initialize(viewer:, game_id:)
    @viewer = viewer
    @game_id = game_id
  end

  def opponents
    @opponents ||= game.players.reject { |player| player == viewer }
  end

  def game
    @game ||= Game.find(game_id)
  end

  private

  attr_reader :viewer, :game_id
end

