require "rails_helper"

RSpec.describe User, type: :model do
  it "creates a new record" do
    user = User.from_omniauth(auth_hash)

    expect(user).to_not be_nil
    expect(user.persisted?).to be true
    expect(user).to be_instance_of User
  end
end
