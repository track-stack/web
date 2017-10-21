class Game < ApplicationRecord

  has_many :user_games
  has_many :players, through: :user_games
  has_many :turns

  def pending?
    status == 0
  end

  def active?
    status == 1
  end

  def ended?
    status == 2
  end

  def self.from(user:, invitee:)
    ActiveRecord::Base.transaction do
      game = Game.create
      UserGame.create(user_id: user.id, game_id: game.id, creator: true)
      UserGame.create(user_id: invitee.id, game_id: game.id, creator: false)
      game
    end
  end
end
