require 'rails_helper'

RSpec.describe Notification::Turn, type: :model do
  it "correctly formats the messages" do
    player = create(:user)
    opponent = create(:user)
    device = create(:device, user: opponent)

    notification = Notification::Turn.new(player: player, opponent: opponent)
    expect(notification.messages.count).to eq(1)

    message = notification.messages.first
    expect(message[:body]).to eq("Your turn against #{player.name}")
    expect(message[:to]).to eq(device.expo_token)
    expect(message[:sound]).to eq("default")
  end
end
