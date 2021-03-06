module Notification
  class Turn < Base
    def initialize(player:, opponent:)
      @player = player
      @opponent = opponent
    end

    def messages
      opponent.devices.map do |device|
        {
          to: device.expo_token,
          body: "Your turn against #{player.name}",
          sound: "default"
        }
      end
    end

    private

    attr_reader :player, :opponent
  end
end
