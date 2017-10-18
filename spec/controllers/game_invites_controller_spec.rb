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
end
