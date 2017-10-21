require 'rails_helper'

RSpec.describe Turn, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game) }

  context "after_create" do
    it "updates game status" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      game = create(:game, status: 0)

      expect(game.playing?).to be false

      turn = create(:turn, game: game, user: user)
      expect(game.playing?).to be false

      turn = create(:turn, game: game, user: user_2)
      expect(game.playing?).to be true
    end
  end
end
