require 'spec_helper'

RSpec.describe Facebook::FriendFinder do
  include Facebook::FriendFinder

  it "does a thing" do
    user = create(:user, :facebook)
    url = send(:fetch_friends_url, user)

    VCR.use_cassette("facebook") do
      reponse = fetch_friends(url)
    end
  end
end
