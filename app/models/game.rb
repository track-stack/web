class Game < ApplicationRecord

  has_many :user_games, dependent: :destroy
  has_many :players, through: :user_games, source: :user
  has_many :turns, dependent: :destroy
  has_many :stacks, dependent: :destroy

  scope :pending, -> { where(status: 0) }
  scope :playing, -> { where(status: 1) }
  scope :ended, -> { where(status: 2) }

  def pending?
    status == 0
  end

  def playing?
    status == 1
  end

  def ended?
    status == 2
  end

  def set_playing!
    update_attributes!({status: 1})
  end

  def self.from(user:, invitee:)
    ActiveRecord::Base.transaction do
      game = Game.create
      Stack.create(game: game)
      UserGame.create(user_id: user.id, game_id: game.id, creator: true)
      UserGame.create(user_id: invitee.id, game_id: game.id, creator: false)
      game
    end
  end
end
