require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController do
  include Devise::Test::ControllerHelpers

  context "with email" do
    before(:each) {
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    }

    it "creates a new user" do
      expect {
        post "facebook"
      }.to change { User.count }.by(1)
    end

    it "does not create a user if one exists" do
      user = User.from_omniauth OmniAuth::AuthHash.new(auth_hash)

      expect {
        post "facebook"
      }.to_not change { User.count }

      expect(session["warden.user.user.key"]).to_not be_nil
    end
  end

  context "without an email address" do
    before(:each) {
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash_without_email
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    }

    it "creates a user without an email" do
      expect  {
        post "facebook"
      }.to change { User.count }.by(1)
    end
  end
end
