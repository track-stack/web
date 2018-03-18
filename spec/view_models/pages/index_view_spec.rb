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

    @stack = create(:stack, game: @user_game)
  end

  context "#active_game_previews" do
    it "returns [] if user is anonymous" do
      view = Pages::IndexView.new(user: nil)
      expect(view.active_game_previews).to eq([])
    end

    it "only returns games created by the viewer" do
      view = Pages::IndexView.new(user: @user)
      game_previews = view.active_game_previews
      expect(game_previews.count).to eq(1)

      game_ids = game_previews.map { |preview| preview.game.id }
      expect(game_ids).to include(@user_game.id)
    end

    it "shows both active and pending games" do
      create(:game, status: 1)
      create(:user_game, user_id: @user.id, game_id: @user_game.id, creator: true)
      create(:user_game, user_id: @user_2.id, game_id: @user_game.id, creator: false)

      view = Pages::IndexView.new(user: @user)
      expect(view.active_game_previews.count).to eq(2)
    end

    it "returns any participating game with a status of 1" do
      view = Pages::IndexView.new(user: @user)
      expect(view.active_game_previews.count).to eq(1)

      @opponent_game.update_attribute(:status, 1)
      view = Pages::IndexView.new(user: @user)
      expect(view.active_game_previews.count).to eq(2)
    end
  end

  context "#invites" do
    it "returns [] if user is anonymous" do
      view = Pages::IndexView.new(user: nil)
      expect(view.invites).to eq([])
    end

    it "only returns games with > 2 turn" do
      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(0)

      create(:turn, user: User.bot, game: @opponent_game, stack: @stack)
      create(:turn, user: @user, game: @opponent_game, stack: @stack)

      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(1)
    end

    it "only returns games not created by the viewer" do
      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(0)

      create(:turn, user: @user, game: @user_game, stack: @stack)

      view = Pages::IndexView.new(user: @user)
      expect(view.invites.count).to eq(0)
    end
  end
end
