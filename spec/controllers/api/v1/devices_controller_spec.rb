require 'rails_helper'

RSpec.describe Api::V1::DevicesController, type: :controller do
  before(:all) do
    @app = Doorkeeper::Application.create(name: "application", redirect_uri: "https://redirect.uri")
    @user = create(:user)
    access_token = @user.generate_access_token(@app.id)
    @token = access_token.token
  end

  context "#register" do
    it "registers a user device if none exist" do
      expect {
        post "register", { params: { access_token: @token, expo_token: "1234", device_id: "1234", app_id: @app.uid }}
      }.to change{Device.count}.by(1)
      expect(response.status).to eq(200)
    end

    it "updates an existing device is one exists" do
      @user.register_device(expo_token: "1234", device_id: "4321")

      expect {
        post "register", { params: { access_token: @token, expo_token: "1234", device_id: "4321", app_id: @app.uid }}
      }.to change{Device.count}.by(0)
      expect(response.status).to eq(200)
    end
  end
end
