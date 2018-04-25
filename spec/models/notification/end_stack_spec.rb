require 'rails_helper'
require 'faker'

RSpec.describe Notification::EndStack, type: :model do
  class TurnStub
    def answer
      @answer ||= Faker::Music.instrument
    end
  end

  it "correctly formats the messages" do
    player = create(:user)
    opponent = create(:user)
    device = create(:device, user: opponent)

    turn = TurnStub.new
    notification = Notification::EndStack.new(player: player, opponent: opponent, turn: turn)
    expect(notification.messages.count).to eq(1)

    message = notification.messages.first
    expect(message[:body]).to eq("#{player.name} ended the stack with #{turn.answer}")
    expect(message[:to]).to eq(device.expo_token)
    expect(message[:sound]).to eq("default")
  end
end
