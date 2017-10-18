require 'spec_helper'

RSpec.describe Facebook::FriendFinder do
  include Facebook::FriendFinder

  it "returns the expected format" do
    user = build(:user, :facebook, :real)

    VCR.use_cassette("facebook") do
      users = find_friends(user)

      expect(users.empty?).to be false

      user = users.first
      expect(user["id"]).not_to be_nil
      expect(user["name"]).not_to be_nil
      expect(user["picture"]["data"]["url"]).not_to be_nil
    end
  end
end
