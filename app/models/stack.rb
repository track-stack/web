class Stack < ApplicationRecord
  belongs_to :game
  has_many :turns

  after_create :generate_turn

  private

  def generate_turn
    turn = Turn.random()
    turn.user = User.bot
    turn.game = self.game
    turn.stack = self
    turn.save
  end
end