class Game < ApplicationRecord

  attr_accessor :players

  def self.from(invite:, invitee:)
    ActiveRecord::Base.transaction do
      invite.accept!
      game = Game.create
      UserGame.create(user_id: invitee.id, game_id: game.id, creator: false)
      UserGame.create(user_id: invite.inviter_id, game_id: game.id, creator: true)

      game
    end
  end
end
