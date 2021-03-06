require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:turns) }
  it { should have_many(:devices) }
  it { should have_many(:games) }
  it { should have_many(:user_games) }
  it { should have_many(:access_tokens) }

  context "#from_omniauth" do
    it "creates a new record" do
      user = User.from_omniauth(auth_hash)

      expect(user).to_not be_nil
      expect(user.persisted?).to be true
      expect(user).to be_instance_of User
    end
  end

  context "#register_device" do
    it "creates a new device" do
      user = create(:user)
      expect {
        user.register_device(expo_token: "1234", device_id: "123")
      }.to change{ Device.count }.by(1)
      expect(user.devices.count).to be(1)
    end

     it "doesn't create a device with the same token" do
       user = create(:user)
       user.register_device(expo_token: "1234", device_id: "432")
       expect {
         user.register_device(expo_token: "1234", device_id: "8473289")
       }.to change{ Device.count }.by(0)
       expect(user.devices.count).to be(1)
     end
  end

  context "#generate_access_token" do
    before(:all) do
      @application = Doorkeeper::Application.create(name: "Test", redirect_uri: "https://test.com")
    end

    it "creates a token" do
      user = create(:user)
      user.generate_access_token(@application.id)
      expect(user.access_tokens.count).to eq(1)
    end

    it "returns the created token" do
      user = create(:user)
      token = user.generate_access_token(@application.id)
      expect(token).to_not be_nil
    end

    it "deletes all existing auth tokens" do
      user = create(:user)
      3.times do
        user.generate_access_token(@application.id)
      end
      expect(user.access_tokens.count).to eq(1)
    end
  end

  context "#active_access_token" do
    before(:all) do
      @application = Doorkeeper::Application.create(name: "Test", redirect_uri: "https://test.com")
    end

    it "returns an access_token if one exists" do
      user = create(:user)
      token = Doorkeeper::AccessToken.create(resource_owner_id: user.id, application: @application)
      expect(user.active_access_token).to eq(token)
    end

    it "returns nil if there are no active tokens" do
      user = create(:user)
      expect(user.active_access_token).to be_nil
    end
  end
end
