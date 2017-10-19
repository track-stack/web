require 'rails_helper'

RSpec.describe Game, type: :model do
  context "#self.from" do
    it "creates a game" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      invite = create(:game_invite, :pending, inviter_id: user.id, invitee_id: user_2.id)

      expect{Game.from(invite: invite, invitee: user_2)}.to change{Game.count}.by(1)
    end

    it "creates user games" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      invite = create(:game_invite, :pending, inviter_id: user.id, invitee_id: user_2.id)

      expect{Game.from(invite: invite, invitee: user_2)}.to change{UserGame.count}.by(2)
    end

    it "accepts the invite" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      invite = create(:game_invite, :pending, inviter_id: user.id, invitee_id: user_2.id)

      expect(invite.pending?).to be true
      Game.from(invite: invite, invitee: user_2)
      expect(invite.reload.pending?).to be false
    end
  end
end
