class Turn < ApplicationRecord
  validates :answer, presence: true

  belongs_to :user
  belongs_to :game
end
