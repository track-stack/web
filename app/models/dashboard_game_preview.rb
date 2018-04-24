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
    @viewers_turn = begin
      return false unless current_stack
      return true if current_stack.ended?
      return true if game.new? && game.creator == viewer
      return true if current_stack.new? && viewer_ended_last_stack?
      return true if !current_stack.new?  && !viewer_took_last_turn?
      false
    end
  end

  def id
    SecureRandom.hex
  end

  def updated_at
    @game.updated_at
  end

  private

  def current_stack
    @current_stack ||= game.stacks.last
  end

  def viewer_ended_last_stack?
    if winner = last_ended_stack_winner
      winner.user_id == viewer.id
    else
      false
    end
  end

  def last_ended_stack_winner
    @winner ||= game.stacks.ended.last&.winner
  end

  def viewer_took_last_turn?
    current_stack.turns.last.user_id == viewer.id
  end

  def opponents
    @opponents ||= game.players.reject { |player| player == viewer }
  end

  attr_reader :viewer
end

