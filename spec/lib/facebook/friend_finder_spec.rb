require 'spec_helper'

RSpec.describe Facebook::FriendFinder do
  include Facebook::FriendFinder

  it "does a thing" do
    user = User.create

    allow_any_instance_of(Facebook::FriendFinder).to receive(:all_friends_for).and_return([])
    expect(all_friends_for(user)).to equal([])
  end
end
