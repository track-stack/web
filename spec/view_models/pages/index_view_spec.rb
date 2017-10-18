require "rails_helper"

RSpec.describe Pages::IndexView, type: :view_model do
  before(:each) do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @sent_invitation = create(:game_invite, :pending, inviter_id: @user_1.id, invitee_id: @user_2.id)
    @received_invitation = create(:game_invite, :pending, inviter_id: @user_2.id, invitee_id: @user_1.id)
  end

  context "#sent_game_invites" do
    it "returns pending game invitations sent from the viewer" do
      view_model = Pages::IndexView.new(user: @user_1)

      expect(view_model.sent_game_invites).to eq([@sent_invitation])
    end

    it "returns [] if viewer is anonymous" do
      view_model = Pages::IndexView.new(user: nil)

      expect(view_model.sent_game_invites).to eq([])
    end
  end

  context "#received_game_invites" do
    it "returns pending game invitations sent from the viewer" do
      view_model = Pages::IndexView.new(user: @user_1)

      expect(view_model.received_game_invites).to eq([@received_invitation])
    end

    it "returns [] if viewer is anonymous" do
      view_model = Pages::IndexView.new(user: nil)

      expect(view_model.received_game_invites).to eq([])
    end
  end
end
