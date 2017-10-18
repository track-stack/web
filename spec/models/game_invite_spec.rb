require 'rails_helper'

RSpec.describe GameInvite, type: :model do

  before(:all) do
    user = create(:user)
    user_2 = create(:user)
    @pending_invitation = create(:game_invite, :pending, inviter_id: user.id, invitee_id: user_2.id)
    @accepted_invitation = create(:game_invite, :accepted, inviter_id: user.id, invitee_id: user_2.id)
  end

  after(:all) do
    GameInvite.destroy_all
    User.destroy_all
  end

  context "scope" do
    it "returns only pending invitations" do
      pending_invitations = GameInvite.pending

      expect(GameInvite.all.count).to equal(2)
      expect(pending_invitations.count).to equal(1)
      expect(pending_invitations.first).to eq(@pending_invitation)
    end

    it "returns only accepted invitations" do
      accepted_invitations = GameInvite.accepted

      expect(GameInvite.all.count).to equal(2)
      expect(accepted_invitations.count).to equal(1)
      expect(accepted_invitations.first).to eq(@accepted_invitation)
    end
  end

  context "#accept" do
    it "accepts an invitation" do
      expect(@pending_invitation.status).to eq(0)
      @pending_invitation.accept!
      expect(@pending_invitation.status).to eq(1)
    end
  end
end