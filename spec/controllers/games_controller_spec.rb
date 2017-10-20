require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  context "show" do
    it "redirects to root if the game isn't found" do
      user = create(:user, :facebook)

      sign_in user
      get "show", { params: { id: 2 }}

      expect(response).to redirect_to("/")
      expect(flash[:error]).to eq("❌ We can't find the game you're looking for")
    end

    it "redirects to root if the viewer is not a member of the game" do
      user = create(:user, :facebook)
      game = create(:game)

      sign_in user
      get "show", { params: { id: game.id }}

      expect(response).to redirect_to("/")
      expect(flash[:error]).to eq("❌ You don't belong in that game")
    end

    it "renders 200" do
      user = create(:user, :facebook)
      user_2 = create(:user, :facebook)
      game = create(:game)
      user_game = create(:user_game, user_id: user.id, game_id: game.id)
      user_game_2 = create(:user_game, user_id: user_2.id, game_id: game.id)

      sign_in user
      get "show", { params: { id: game.id }}

      expect(response.status).to eq(200)
      expect(flash[:error]).to be_nil
    end
  end
end

