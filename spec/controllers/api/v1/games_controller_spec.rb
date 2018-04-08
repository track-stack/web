require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do

  before(:all) do
    @app = Doorkeeper::Application.create(name: "app",
                                          redirect_uri: "https://redirect.com")
    @user = create(:user)
    access_token = @user.generate_access_token(@app.id)
    @token = access_token.token

    @game = create(:game)
    opponent = create(:user)
    create(:user_game, game_id: @game.id, user_id: @user.id)
    create(:user_game, game_id: @game.id, user_id: opponent.id)

  end

  context "#show" do
    it "renders 404 if the game is not found" do
      get "show", { params: { app_id: @app.uid, access_token: @token, id: 2 }}

      expect(response.status).to eq(404)
    end

    it "renders 404 if the viewer is not a member of the game" do
      user = create(:user, :facebook)
      token = user.generate_access_token(@app.id).token
      game = create(:game)

      get "show", { params: { id: game.id, app_id: @app.uid, access_token: token }}
      expect(response.status).to eq(404)
    end

    it "renders 200" do
      params = { app_id: @app.uid, access_token: @token, id: @game.id  }
      get "show", { params: params }

      expect(response.status).to eq(200)
    end

    it "renders game json" do
      stack = create(:stack, game: @game)
      create(:turn, game: @game, user: @user, stack: stack)

      params = { id: @game.id, app_id: @app.uid, access_token: @token  }
      get "show", { params: params }

      json = JSON.parse(response.body)
      game = json["game"]
      stacks = game["stacks"]

      expect(stacks.count).to equal(1)
      expect(stacks.first["turns"].count).to eq(2)
    end
  end

  context "#turn" do
    it "renders errors if turn is invalid" do
      match = { name: "Testify", artist: "Rage Against the Machine",
                image: "http://image.png" }

      params = { id: @game.id, match: match, app_id: @app.uid,
                 access_token: @token }

      post "turn", { params: params }

      json = JSON.parse(response.body)
      expect(response.status).to eq(400)
      expect(json["errors"]).not_to be_empty
    end

  context "when turn is valid" do
    it "renders status 200" do
      create(:stack, game: @game)
      match = { name: "Testify", artist: "Rage Against the Machine",
                image: "http://image.png" }
      answer = "Concrete Genesha by Torres"
      params = { id: @game.id, answer: answer, match: match, app_id: @app.uid,
                 access_token: @token }

      post "turn", { params: params }

      expect(response.status).to eq(200)
    end

    it "creates a Turn with valid associations" do
      create(:stack, game: @game)
      match = { name: "Testify", artist: "Rage Against the Machine",
                image: "http://image.png" }
      answer = "Concrete Genesha by Torres"
      params = { id: @game.id, answer: answer, match: match, app_id: @app.uid,
                 access_token: @token }

      expect {
        post "turn", { params: params }
      }.to change{ Turn.count }.by(1)

      expect(Turn.last.user).to eq(@user)
      expect(Turn.last.game).to eq(@game)
    end
  end

   context "winning" do
     it "creates a StackWinner record if the stack is over" do
       stack = create(:stack, game: @game)
       5.times { |i| create(:turn, game: @game, stack: stack, user: @user) }

       match = { name: "Testify", artist: "Rage Against the Machine",
                 image: "http://image.png" }

       params = { id: @game.id, answer: "Concrete Ganesha by Torres",
                  match: match, game_over: true, app_id: @app.uid,
                  access_token: @token }

       post "turn", { params: params }

       stack.reload

       expect(stack.ended_at).not_to be(nil)
       expect(stack.stack_winners.count).to eq(1)
     end

     it "doesn't create a StackWinner record if the stack isn't over" do
       stack = create(:stack, game: @game)
       match = { name: "Testify", artist: "Rage Against the Machine",
                 image: "http://image.png" }

       params = { id: @game.id, answer: "Concrete Ganesha by Torres",
                  match: match, game_over: true, app_id: @app.uid,
                  access_token: @token }

       post "turn", { params: params }

       stack.reload

       expect(stack.ended_at).to be(nil)
       expect(stack.stack_winners.count).to eq(0)
     end
   end
  end
end
