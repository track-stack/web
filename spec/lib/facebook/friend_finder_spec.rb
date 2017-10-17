require 'spec_helper'

RSpec.describe Facebook::FriendFinder do
  include Facebook::FriendFinder

  it "does a thing" do
    user = create(:user, :facebook)

    expected_json = fb_api_json(:friends)
    allow_any_instance_of(Facebook::FriendFinder).to receive(:fetch_friends).and_return(expected_json)

    expect(all_friends_for(user).count).to equal(9)
  end
end
