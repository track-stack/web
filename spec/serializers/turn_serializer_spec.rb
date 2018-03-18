require 'rails_helper'

RSpec.describe TurnSerializer do
  it "serializes" do
    game = create(:game)
    user = create(:user)
    stack = create(:stack, game: game)
    turn = create(:turn, user: user, game: game, stack: stack)

    hash = TurnSerializer.new(turn).to_hash
    turn_json = hash[:data][:attributes]

    expected_attributes = [:id, :user_id, :answer, :created_at, :match,
                           :user_photo, :has_exact_name_match, :has_exact_artist_match]
    expect(turn_json.keys).to eq(expected_attributes)
  end
end
