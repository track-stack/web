require 'rails_helper'

RSpec.describe Turn, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game) }
  it { should belong_to(:round) }

  context "after_create" do
    it "updates game status" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      game = create(:game, status: 0)
      round = create(:round, game: game)

      expect(game.playing?).to be false

      turn = create(:turn, game: game, user: user, round: round)
      expect(game.playing?).to be false

      turn = create(:turn, game: game, user: user_2, round: round)
      expect(game.playing?).to be true
    end
  end
end
