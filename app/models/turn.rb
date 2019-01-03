class Turn < ApplicationRecord
  include WordSanitizer
  extend TrackGenerator

  validates :answer, presence: true

  belongs_to :user
  belongs_to :game
  belongs_to :stack

  after_create_commit :mark_game_as_playing
  before_create :find_exact_matches

  def has_exact_artist_match?
    !exact_artist_match.nil?
  end

  def has_exact_name_match?
    !exact_name_match.nil?
  end

  def self.random
    track = generate_track
    name = track["name"]
    artist = track["artist"]["name"]
    image = track["image"].last["#text"]
    match = {
      name: name,
      artist: artist,
      image: image
    }
    Turn.new(answer: [name, artist].join(" - "), match: match)
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

  # Relies on implicit save that occurs right after this method
  def find_exact_matches
    name = sanitize_result(match["name"])
    artist = sanitize_result(match["artist"])
    sanitized_answer = sanitize_result(answer)

    self.exact_name_match = /#{name}/.match(sanitized_answer).to_a.first
    self.exact_artist_match = /#{artist}/.match(sanitized_answer).to_a.first
  end
end
