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

    it "finds exact matches" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      game = create(:game, status: 0)
      round = create(:round, game: game)
      turn = create(:turn,
        game: game,
        user: user,
        round: round,
        answer: "something in the way she moves by James Taylor",
        match: { name: "Something in the Way She Moves", artist: "James Taylor" }
      )

      expect(turn.exact_artist_match).to eq("james taylor")
      expect(turn.exact_name_match).to eq("something way she moves")
    end
  end

  context "#has_exact_artist_match?" do
    it "returns true if there was an artist match in the answer" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      game = create(:game, status: 0)
      round = create(:round, game: game)

      turn = create(:turn,
        game: game,
        user: user,
        round: round,
        answer: "something in the way she moves by James Taylor",
        match: { name: "song", artist: "James Taylor" }
      )

      expect(turn.has_exact_artist_match?).to be true
    end
  end

  context "#has_exact_name_match?" do
    it "returns true if there was an artist match in the answer" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      game = create(:game, status: 0)
      round = create(:round, game: game)

      turn = create(:turn,
        game: game,
        user: user,
        round: round,
        answer: "jumping jack flash by the rolling stones",
        match: { name: "jumping jack flash", artist: "the rolling stones" }
      )

      expect(turn.has_exact_name_match?).to be true
    end
  end
end
