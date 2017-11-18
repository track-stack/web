require 'rails_helper'

RSpec.describe Round, type: :model do

  it { should have_many(:turns) }
  it { should belong_to(:game) }

  context "#after_create" do
    it "generates a random turn" do
      game = create(:game)
      round = Round.create(game: game)

      expect(round.turns.count).to eq(1)
    end
  end
end
