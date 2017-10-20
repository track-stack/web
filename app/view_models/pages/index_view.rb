module Pages
  class IndexView < ViewModel

    def initialize(user:)
      @user = user
    end

    def user_games
      return [] unless user

      @user_games ||= begin
        game_ids = user.games.where("user_games.creator = true").pluck(:id)
        UserGame
          .includes(:user)
          .includes(:game)
          .where("game_id in (?) and user_id != ?", game_ids, user.id)
      end
    end

    def invites
      return [] unless user

      @invites ||= begin
        game_ids = user.games.where("user_games.creator = false").pluck(:id)
        UserGame.includes(:user).includes(:game).joins(:game).where("game_id in (?) and user_id != ? and games.status = 0", game_ids, user.id)
      end
    end

    private

    attr_reader :user
  end
end
