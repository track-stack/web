require 'rails_helper'

RSpec.describe Round, type: :model do

  it { should have_many(:turns) }
  it { should belong_to(:game) }

  context "#after_create" do
    it "generates a random turn" do
      user = create(:user, email: "bot@trackstack.com")
      stub_const("User::BOT", user)
      allow(Turn).to receive(:random) {
        Turn.new(
          answer: "I Bet You Look Good on the Dancefloor - Arctic Monkeys",
          match: {
            name: "I Bet You Look Good on the Dancefloor - Arctic Monkeys",
            artist: "Arctic Monkeys"
          }
         )
      }

      game = create(:game)
      round = Round.create(game: game)

      expect(round.turns.count).to eq(1)
    end
  end
end
