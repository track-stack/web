module Pages
  class IndexView < ViewModel

    def initialize(user:)
      @user = user
    end

    def user_games
      return [] unless user

      @user_games ||= begin
        game_ids = user.games.where("user_games.creator = true OR games.status = 1").pluck(:id)

        UserGame
          .joins(:game)
          .includes(:user)
          .includes(:game)
          .where("game_id IN (?) AND user_id != ? AND games.status != 2", game_ids.uniq, user.id)
      end
    end

    def invites
      return [] unless user

      @invites ||= begin
        game_ids = user.games.where("user_games.creator = false").pluck(:id)

        # TODO: turn_count could be cached on Game
        turns = Turn.where("game_id IN (?)", game_ids)
          .group("game_id")
          .select("COUNT(*) AS total_count, turns.game_id AS game_id")
        turns = turns.reject { |turn| turn.total_count ==  0 }
        turn_game_ids = turns.map(&:game_id)

        UserGame
          .joins(:game)
          .includes(:user)
          .includes(:game)
          .where("game_id IN (?) AND user_id != ? AND games.status = 0", turn_game_ids, user.id)
      end
    end

    private

    attr_reader :user
  end
end
