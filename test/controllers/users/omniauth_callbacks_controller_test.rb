require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def auth_hash
    @auth_hash ||= begin
      file_path = Rails.root.join("test", "fixtures", "facebook_omniauth_hash.json")
      file = File.read(file_path)
      json = JSON.parse(file)
      OmniAuth::AuthHash.new(json)
    end
  end

  def auth_hash_without_email
    @auth_hash ||= begin
      file_path = Rails.root.join("test", "fixtures", "facebook_omniauth_hash.json")
      file = File.read(file_path)
      json = JSON.parse(file)
      json.delete :email
      OmniAuth::AuthHash.new(json)
    end
  end

  test "creates a new user" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    assert_difference "User.count" do
      post "facebook"
    end
    assert_redirected_to root_path
  end

  test "creates a user without an email" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash_without_email
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    assert_difference "User.count" do
      post "facebook"
    end
    assert_redirected_to root_path
  end

  test "does not create a user if one exists" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    user = User.from_omniauth OmniAuth::AuthHash.new(auth_hash)
    post "facebook"

    assert session["warden.user.user.key"]
    assert_redirected_to root_path
  end
end
