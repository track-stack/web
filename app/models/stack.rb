class Stack < ApplicationRecord
  belongs_to :game
  has_many :turns
  has_many :stack_winners

  after_create :generate_turn

  def can_end?
    turns.count >= 5
  end

  def mark_winner!(user)
    StackWinner.create(
      user: user,
      stack: self,
      score: self.turns.count
    ) 
    update_attributes!(ended_at: Time.now)
  end

  private

  def generate_turn
    turn = Turn.random()
    turn.user = User.bot
    turn.game = self.game
    turn.stack = self
    turn.save
  end
end
