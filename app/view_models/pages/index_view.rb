module Pages
  class IndexView < ViewModel

    def initialize(user:)
      @user = user
    end

    def sent_game_invitations
      return [] unless user
      @sent_game_invitations ||= begin
        invitations = user
          .game_invitations
          .joins("INNER JOIN users ON users.id = game_invitations.invitee_id")
          .select("users.name, users.image, game_invitations.id, game_invitations.inviter_id, game_invitations.invitee_id")
        invitations.select { |invitation| invitation.inviter_id == user.id }
      end
    end

    def received_game_invitations
      return [] unless user
      @received_game_invitations ||= begin
        invitations = user
          .game_invitations
          .joins("INNER JOIN users ON users.id = game_invitations.inviter_id")
          .select("users.name, users.image, game_invitations.id, game_invitations.inviter_id, game_invitations.invitee_id")
        invitations.select { |invitation| invitation.invitee_id == user.id }
      end
    end

    private

    attr_reader :user
  end
end
