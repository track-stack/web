require 'rails_helper'

RSpec.describe DashboardGamePreview, type: :model do
  context "#opponent" do
    it "returns the non-viewer player" do
      viewer = create(:user)
      opponent = create(:user)
      game = create(:game)
      create(:user_game, user: viewer, game: game)
      create(:user_game, user: opponent, game: game)

      game_preview = DashboardGamePreview.new(viewer: viewer, game: game)

      expect(game_preview.opponent).to eq(opponent)
    end
  end

  context "#updated_at" do
    it "returns game.updated_at" do
      game = create(:game, updated_at: Time.now)
      game_preview = DashboardGamePreview.new(viewer: create(:user), game: game)

      expect(game_preview.updated_at).to eq(game.updated_at)
    end
  end

  context "#viewers_turn" do
    it "return true if it's a new game created by the viewer" do
      viewer = create(:user)
      game = create(:game)
      create(:user_game, user: viewer, game: game, creator: true)
      create(:user_game, user: create(:user), game: game)

      game_preview = DashboardGamePreview.new(viewer: viewer, game: game)
      expect(game_preview.viewers_turn?).to eq(true)
    end

    it "returns true if the lastest stack is new and the viewer ended the previous stack" do
      viewer = create(:user)
      opponent = create(:user)
      game = create(:game)
      create(:user_game, user: viewer, game: game)
      create(:user_game, user: opponent, game: game)
      stack = create(:stack, game: game)
      create(:turn, game: game, user: opponent, stack: stack)
      stack.mark_winner!(viewer)

      stack2 = create(:stack, game: game)
      create(:turn, game: game, user: create(:user), stack: stack2)

      game_preview = DashboardGamePreview.new(viewer: viewer, game: game)
      expect(game_preview.viewers_turn?).to eq(true)
    end

    it "returns true if the stack is not new and the lastest turn does not belong to the viewer" do
      viewer = create(:user)
      opponent = create(:user)
      game = create(:game)
      create(:user_game, user: viewer, game: game)
      create(:user_game, user: opponent, game: game)
      stack = create(:stack, game: game)
      create(:turn, game: game, user: opponent, stack: stack)
      create(:turn, game: game, user: viewer, stack: stack)
      create(:turn, game: game, user: opponent, stack: stack)

      game_preview = DashboardGamePreview.new(viewer: viewer, game: game)
      expect(game_preview.viewers_turn?).to eq(true)
    end

    it "return false if the stack is not new and the latest turn belongs to the user" do
      viewer = create(:user)
      opponent = create(:user)
      game = create(:game)
      create(:user_game, user: viewer, game: game)
      create(:user_game, user: opponent, game: game)
      stack = create(:stack, game: game)
      create(:turn, game: game, user: opponent, stack: stack)
      create(:turn, game: game, user: viewer, stack: stack)

      game_preview = DashboardGamePreview.new(viewer: viewer, game: game)
      expect(game_preview.viewers_turn?).to eq(false)
    end
  end
end
