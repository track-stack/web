class Turn < ApplicationRecord
  validates :answer, presence: true

  belongs_to :user
  belongs_to :game

  after_create_commit :mark_game_as_playing

  private

  def mark_game_as_playing
    if game.status == 0 && game.turns.count > 1
      begin
        game.set_playing!
      rescue
        # log error
      end
    end
  end
end
