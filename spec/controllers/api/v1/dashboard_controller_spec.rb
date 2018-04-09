require 'rails_helper'

RSpec.describe Api::V1::DashboardController, type: :controller do
  before(:all) do
    @app = Doorkeeper::Application.create(name: "application", redirect_uri: "https://redirect.uri")
    @user = create(:user)
    access_token = @user.generate_access_token(@app.id)
    @token = access_token.token
  end

  context "#index" do
    it "renders 200" do
      get "index", { params: { app_id: @app.uid, access_token: @token }}
      expect(response.status).to eq(200)
    end

    it "groups by turn" do
      get "index", { params: { app_id: @app.uid, access_token: @token }}
      parsed = JSON.parse(response.body)
      their_turns = parsed["active_game_previews"]["Their turn"]
      your_turns = parsed["active_game_previews"]["Your turn"]
      expect(their_turns).to be_empty
      expect(your_turns).to be_empty
    end

    it "sorts by updated_at" do
      game1 = create_game(1.days.ago)
      game2 = create_game(3.days.ago)
      game3 = create_game(5.day.ago)

      get "index", { params: { app_id: @app.uid, access_token: @token }}
      parsed = JSON.parse(response.body)
      turns = parsed["active_game_previews"]["Their turn"]
      expect(turns[0]["game_id"]).to eq(game1.id)
      expect(turns[1]["game_id"]).to eq(game2.id)
      expect(turns[2]["game_id"]).to eq(game3.id)
    end
  end

  def create_game(updated_at)
    game = create(:game, updated_at: updated_at)
    stack = create(:stack, game: game)
    create(:user_game, game: game, user: @user, creator: true)
    create(:user_game, game: game, user: create(:user))
    create(:turn, user: @user, game: game, stack: stack)
    game
  end
end
