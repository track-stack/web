module Games
  class ShowView < ViewModel
    attr_reader :game

    def initialize(user:, game:)
      @user = user
      @game = game
    end

    def user_games
      @user_games ||= begin
        user_games = UserGame.includes(:user).where(game_id: game.id)
        viewer_user_game = user_games.detect { |user_game| user_game.user_id == user.id }
        {me: viewer_user_game, opponent: (user_games - [viewer_user_game]).first }
      end
    end


    private

    attr_reader :user
  end
end

