require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:turns) }
  it { should have_many(:stacks) }
  it { should have_many(:user_games) }

  context "#self.from" do
    it "creates a game" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)

      expect{Game.from(user: user, invitee: user_2)}.to change{Game.count}.by(1)
    end

    it "creates user games" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)

      expect{Game.from(user: user, invitee: user_2)}.to change{UserGame.count}.by(2)
    end

    it "creates a stack" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)

      expect{Game.from(user: user, invitee: user_2)}.to change{Stack.count}.by(1)
    end
  end
end
