require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do

  before(:all) do
    @application = Doorkeeper::Application.create(name: "Test", redirect_uri: "https://example.com")
  end

  it "works with a valid token" do
    user = build(:user, :facebook, :real)
    token = user.oauth_token
    context do
      post "create", {params: { token: token, app_id: @application.uid }}
      expect(response.status).to eq(200)
    end
  end

  it "creates a new user" do
    user = build(:user, :facebook, :real)
    token = user.oauth_token
    context do
      expect {
        post "create", {params: { token: token, app_id: @application.uid }}
      }.to change { User.count }.by(1)
    end
  end

  it "finds a user if one exists" do
    user = build(:user, :facebook, :real)
    token = user.oauth_token
    context do
      post "create", {params: { token: token, app_id: @application.uid }}
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
