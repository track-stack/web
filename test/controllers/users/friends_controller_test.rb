require 'test_helper'

class FriendsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def auth_hash
    @auth_hash ||= begin
      file_path = Rails.root.join("test", "fixtures", "facebook_omniauth_hash.json")
      file = File.read(file_path)
      json = JSON.parse(file)
      OmniAuth::AuthHash.new(json)
    end
  end

  test "renders 401 for anonymous user" do
    get "list"
    assert_response 401
  end

  test "renders 200 for logged in user" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    user = User.from_omniauth OmniAuth::AuthHash.new(auth_hash)

    sign_in user, scope: :user

    get "list"
    assert_response 200
  end
end

