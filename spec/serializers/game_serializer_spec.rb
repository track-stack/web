require 'rails_helper'

RSpec.describe GameSerializer do
  it "serializes" do
    game = create(:game)
    user = create(:user, :facebook)
    user_2 = create(:user, :facebook)
    user_game = create(:user_game, game_id: game.id, user_id: user.id)
    user_game_2 = create(:user_game, game_id: game.id, user_id: user_2.id)

    json = JSON.parse(GameSerializer.new(game, viewer: user).to_json)

    expect(json["id"]).to eq(game.id)
    expect(json["status"]).to eq(game.status)

    viewer = json["players"]["viewer"]
    opponent = json["players"]["opponent"]

    expect(viewer["id"]).to eq(user.id)
    expect(viewer["name"]).to eq(user.name)
    expect(opponent["id"]).to eq(user_2.id)
    expect(opponent["name"]).to eq(user_2.name)
  end
end
