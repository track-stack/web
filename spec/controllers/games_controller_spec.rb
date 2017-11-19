require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    @game = create(:game)
    @stack = create(:stack, game: @game)
    @user = create(:user, :facebook)
    user_2 = create(:user, :facebook)
    user_game = create(:user_game, user_id: @user.id, game_id: @game.id)
    user_game_2 = create(:user_game, user_id: user_2.id, game_id: @game.id)
  end

  context "#show" do
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
      sign_in @user
      get "show", { params: { id: @game.id }}

      expect(response.status).to eq(200)
      expect(flash[:error]).to be_nil
    end

    it "renders game json" do
      turn = create(:turn, game: @game, user: @user, stack: @stack)

      sign_in @user
      get "show", { params: { id: @game.id }, xhr: true}

      json = JSON.parse(response.body)
      game = json["game"]
      stacks = game["stacks"]
      expect(stacks.count).to equal(1)
      expect(stacks.first["turns"].count).to eq(2)
    end
  end

  context "#turn" do
    it "redirects to game path if turn is invalid" do
      match = { name: "Testify", artist: "Rage Against the Machine", image: "http://image.png" }

      sign_in @user
      post "turn", { params: { id: @game.id, match: match }}

      expect(response).to redirect_to(game_path(@game))
    end

    context "when turn is valid" do
      it "renders status 200" do
        match = { name: "Testify", artist: "Rage Against the Machine", image: "http://image.png" }

        sign_in @user
        post "turn", { params: { id: @game.id, answer: "Concrete Ganesha by Torres", match: match }}

        expect(response.status).to eq(200)
      end

      it "creates a Turn with valid associations" do
        sign_in @user

        match = { name: "Testify", artist: "Rage Against the Machine", image: "http://image.png" }
        expect {
          post "turn", { params: { id: @game.id, answer: "Concrete Ganesha by Torres", match: match }}
        }.to change{ Turn.count }.by(1)

        expect(Turn.last.user).to eq(@user)
        expect(Turn.last.game).to eq(@game)
      end
    end

    context "winning" do
      it "creates a StackWinner record if the stack is over" do
        5.times { |i| create(:turn, game: @game, stack: @stack, user: @user) }

        match = { name: "Testify", artist: "Rage Against the Machine", image: "http://image.png" }

        sign_in @user
        post "turn", { params: { 
          id: @game.id, 
          answer: "Concrete Ganesha by Torres", 
          match: match,
          game_over: true
        }}

        @stack.reload

        expect(@stack.ended_at).not_to be(nil)
        expect(@stack.stack_winners.count).to eq(1)
      end

      it "doesn't create a StackWinner record if the stack isn't over" do
        match = { name: "Testify", artist: "Rage Against the Machine", image: "http://image.png" }

        sign_in @user
        post "turn", { params: { 
          id: @game.id, 
          answer: "Concrete Ganesha by Torres", 
          match: match,
          game_over: true
        }}

        @stack.reload

        expect(@stack.ended_at).to be(nil)
        expect(@stack.stack_winners.count).to eq(0)
      end
    end
  end
end
