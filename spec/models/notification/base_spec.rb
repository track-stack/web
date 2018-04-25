require 'rails_helper'

RSpec.describe Notification::Base, type: :model do
  it "doesn't try to publish events if the device.expo_token is invalid" do
    expect_any_instance_of(Exponent::Push::Client).not_to receive(:publish)

    notification = Notification::Base.new
    allow(notification).to receive(:messages).and_return [{to: nil}]
    notification.send
  end
end
