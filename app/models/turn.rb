class Turn < ApplicationRecord
  validates :answer, presence: true

  belongs_to :user
  belongs_to :game
  belongs_to :round

  after_create_commit :mark_game_as_playing
  before_create :find_exact_matches

  def has_exact_artist_match?
    !exact_artist_match.nil?
  end

  def has_exact_name_match?
    !exact_name_match.nil?
  end

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

  def find_exact_matches
    name = match["name"].downcase
    artist = match["artist"].downcase

    self.exact_name_match = /#{name}/.match(answer.downcase).to_a.first
    self.exact_artist_match = /#{artist}/.match(answer.downcase).to_a.first
  end
end
