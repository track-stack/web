require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new auth_hash
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it "works with a valid token" do
    user = build(:user, :facebook, :real)
    token = user.oauth_token
    context do
      post "create", {params: { token: token }}
      expect(response.status).to eq(200)
    end
  end

  it "creates a new user" do
    user = build(:user, :facebook, :real)
    token = user.oauth_token
    context do
      expect {
        post "create", {params: { token: token }}
      }.to change { User.count }.by(1)
    end
  end

  it "finds a user if one exists" do
    user = build(:user, :facebook, :real)
    token = user.oauth_token
    context do
      post "create", {params: { token: token }}
      expect {
        post "create", {params: { token: token }}
      }.to change { User.count }.by(0)
    end
  end

  def context
    VCR.use_cassette("facebook_auth") do
      yield
    end
  end
end
