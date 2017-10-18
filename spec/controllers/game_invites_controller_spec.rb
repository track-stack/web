RSpec.describe GameInvitesController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  context "create" do
    it  "redirects to users/sign_in if user in anonymous" do
      post "create"
      expect(response).to redirect_to("/users/sign_in")
    end

    it  "does not create a game invitation and redirects back" do
      user = create(:user, :facebook)

      sign_in user
      post "create"

      expect(response).to redirect_to("/games/new")
    end

    it  "creates a game invitation and redirects to root" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)

      sign_in user
      post "create", { params: { uid: user_2.uid }}

      expect(response).to redirect_to("/")
    end
  end

  context "#accept" do
    it "it redirect to root if there's no invite" do
      user = create(:user, :facebook)

      sign_in user
      put "accept", { params: { game_invite_id: 1 }}

      expect(flash[:error]).to eq("The invitation couldn't be found")
      expect(response).to redirect_to("/")
    end

    it "it redirects to root if someone else tries to accept an invite" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      invite = create(:game_invite, :pending, inviter_id: user.id, invitee_id: user_2.id)

      sign_in user
      put "accept", { params: { game_invite_id: invite.id }}


      expect(flash[:error]).to eq("You can't accept someone else's invite")
      expect(response).to redirect_to("/")
    end

     it "accepts the invitation" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      invite = create(:game_invite, :pending, inviter_id: user.id, invitee_id: user_2.id)

      sign_in user_2
      put "accept", { params: { game_invite_id: invite.id }}

      expect(flash[:error]).to be_nil
      expect(invite.reload.status).to eq(1)
      expect(response).to redirect_to("/")
     end
  end
end