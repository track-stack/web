require "rails_helper"

RSpec.describe Pages::IndexView, type: :view_model do
  before(:each) do
    @user = create(:user, :facebook)
    @user_2 = create(:user, :facebook)

    @user_game = create(:game)
    create(:user_game, user_id: @user.id, game_id: @user_game.id, creator: true)
    create(:user_game, user_id: @user_2.id, game_id: @user_game.id, creator: false)

    @opponent_game = create(:game)
    create(:user_game, user_id: @user.id, game_id: @opponent_game.id, creator: false)
    create(:user_game, user_id: @user_2.id, game_id: @opponent_game.id, creator: true)
  end

  context "#user_games" do
    it "returns [] if user is anonymous" do
      view = Pages::IndexView.new(user: nil)
      expect(view.user_games).to eq([])
    end

    it "only returns games created by the viewer" do
      view = Pages::IndexView.new(user: @user)
      expect(view.user_games.count).to eq(1)
      expect(view.user_games.map(&:game_id)).to include(@user_game.id)
    end

    it "shows both active and pending games" do
      active_game = create(:game, status: 1)
      create(:user_game, user_id: @user.id, game_id: @user_game.id, creator: true)
      create(:user_game, user_id: @user_2.id, game_id: @user_game.id, creator: false)

      view = Pages::IndexView.new(user: @user)
      expect(view.user_games.count).to eq(2)
    end

    it "returns any game with a status of 1" do
      view = Pages::IndexView.new(user: @user)
      expect(view.user_games.count).to eq(1)

      @opponent_game.update_attribute(:status, 1)
      view = Pages::IndexView.new(user: @user)
      expect(view.user_games.count).to eq(2)
    end
  end

  context "#invites" do
    it "returns [] if user is anonymous" do
      view = Pages::IndexView.new(user: nil)
      expect(view.invites).to eq([])
    end

    it "only returns games with > 1 turn" do
      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(0)

      create(:turn, user: @user, game: @opponent_game)

      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(1)
    end

    it "only returns games not created by the viewer" do
      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(0)

      create(:turn, user: @user, game: @user_game)

      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(0)
    end
  end
end
