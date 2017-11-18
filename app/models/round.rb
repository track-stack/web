class Round < ApplicationRecord
  belongs_to :game
  has_many :turns

  after_create :generate_turn

  private

  def generate_turn
    turn = Turn.random()
    turn.user = User::BOT
    turn.game = self.game
    turn.round = self
    turn.save
  end
end
