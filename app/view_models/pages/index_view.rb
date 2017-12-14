module Pages
  class IndexView < ViewModel

    def initialize(user:)
      @user = user
    end

    def user_games
      return [] unless user

      @user_games ||= begin
        game_ids = user.games.where("user_games.creator = true").pluck(:id)
        game_ids += user.games.where(status: 1).pluck(:id)

        UserGame
          .joins(:game)
          .includes(:user)
          .includes(:game)
          .where("game_id in (?) and user_id != ? and games.status != 2", game_ids.uniq, user.id)
      end
    end

    def invites
      return [] unless user

      @invites ||= begin
        # find games that the viewer did not create
        game_ids = user.games.where("user_games.creator = false").pluck(:id)

        # TODO: turn_count could be cached on Game
        # Find # of turns for each game { game_id: turn_count }
        turns = Turn.where("game_id in (?)", game_ids)
          .group("game_id")
          .select("count(*) as total_count, turns.game_id as game_id")
        turns = turns.reject { |turn| turn.total_count < 2 }
        turn_game_ids = turns.map(&:game_id)

        # Find all user_games for games not created by the viewer where the status = "pending"
        # and the turn count > 2 and the user_id != viewer.id
        UserGame
          .joins(:game)
          .includes(:user)
          .includes(:game)
          .where("game_id in (?) and user_id != ? and games.status = 0", turn_game_ids, user.id)
      end
    end

    private

    attr_reader :user
  end
end
