module Pages
  class IndexView < ViewModel

    def initialize(user:)
      @user = user
    end

    def active_game_previews
      return [] unless user

      @user_games ||= begin
        previews = active_user_games.map do |game|
          DashboardGamePreview.new(viewer: user, game: game)
        end

        previews
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

    def active_user_games
      @active_user_games ||= Game.where(id: active_user_game_ids).
        includes(:turns, :players)
    end

    def active_user_game_ids
      @active_user_games ||= user.games.
        where("user_games.creator = true and status != 2 or status = 1").
        pluck(:id)
    end
  end
end
