module Pages
  class IndexView < ViewModel

    def initialize(user:)
      @user = user
    end

    def user_games
      return [] unless user

      @user_games ||= begin
        game_ids = user.games.pluck(:id)
        UserGame
          .joins(:user)
          .where("game_id in (?) and user_id != ?", game_ids, user.id)
      end
    end

    def sent_game_invites
      return [] unless user

      @sent_game_invites ||= begin
        invitations = user
          .game_invites(:sent)
          .pending
          .joins("INNER JOIN users ON users.id = game_invites.invitee_id")
          .select("users.name, users.image, game_invites.id, game_invites.inviter_id, game_invites.invitee_id")
        invitations.select { |invitation| invitation.inviter_id == user.id }
      end
    end

    def received_game_invites
      return [] unless user

      @received_game_invites ||= begin
        invitations = user
          .game_invites(:received)
          .pending
          .joins("INNER JOIN users ON users.id = game_invites.inviter_id")
          .select("users.name, users.image, game_invites.id, game_invites.inviter_id, game_invites.invitee_id")
        invitations.select { |invitation| invitation.invitee_id == user.id }
      end
    end

    private

    attr_reader :user
  end
end
