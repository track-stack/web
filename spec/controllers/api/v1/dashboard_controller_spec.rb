require 'rails_helper'

RSpec.describe Api::V1::DashboardController, type: :controller do
  before(:all) do
    @app = Doorkeeper::Application.create(name: "application", redirect_uri: "https://redirect.uri")
    @user = create(:user)
    access_token = @user.generate_access_token(@app.id)
    @token = access_token.token
  end

  context "#index" do
    it "renders 200" do
      get "index", { params: { app_id: @app.uid, access_token: @token }}
      expect(response.status).to eq(200)
    end
  end
end
