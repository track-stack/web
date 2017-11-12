class Round < ApplicationRecord
  belongs_to :game
  has_many :turns, -> { order("created_at DESC") }
end
