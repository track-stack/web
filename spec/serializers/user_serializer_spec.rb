require 'rails_helper'

RSpec.describe UserSerializer do
  it "serializes" do
    user = create(:user, :facebook)
    hash = UserSerializer.new(user, {meta: {score: 10}}).to_hash
    user_json = hash[:data][:attributes].merge(hash[:meta])

    expect(user_json.keys).to eq([:id, :name, :image, :score])
    expect(user_json[:name]).to eq(user.name)
    expect(user_json[:id]).to eq(user.id)
  end
end
