require 'rails_helper'

RSpec.describe GameSerializer do
  it "serializes" do
    game = create(:game)
    user = create(:user, :facebook)
    user_2 = create(:user, :facebook)
    create(:user_game, game_id: game.id, user_id: user.id)
    create(:user_game, game_id: game.id, user_id: user_2.id)

    serializable = Serializable::Game.new(game: game, viewer: user)

    hash = GameSerializer.new(serializable).to_hash
    game_json = hash[:data][:attributes]

    expect(game_json[:id]).to eq(game.id)
    expect(game_json[:status]).to eq(game.status)
    expect(game_json[:viewers_turn]).to be(false)

    viewer = game_json[:players][:viewer]
    opponent = game_json[:players][:opponent]

    expect(viewer[:id]).to eq(user.id)
    expect(viewer[:name]).to eq(user.name)
    expect(opponent[:id]).to eq(user_2.id)
    expect(opponent[:name]).to eq(user_2.name)
  end
end
