require 'rails_helper'

RSpec.describe FriendsController do
  include Devise::Test::ControllerHelpers

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it "renders 401 for anonymous user" do
    get "list"
    assert_response 401
  end

  it "renders 200 for logged in user" do
    allow_any_instance_of(FriendsController).to receive(:find_friends).and_return([])

    user = User.from_omniauth OmniAuth::AuthHash.new(auth_hash)

    sign_in user, scope: :user

    get "list"
    assert_response 200
  end
end

