require 'rails_helper'

RSpec.describe UserSerializer do
  it "serializes" do
    user = create(:user, :facebook)
    serialized_user_json = JSON.parse(UserSerializer.new(user).to_json)

    expect(serialized_user_json.keys).to eq(["id", "name"])
    expect(serialized_user_json["name"]).to eq(user.name)
    expect(serialized_user_json["id"]).to eq(user.id)
  end
end
