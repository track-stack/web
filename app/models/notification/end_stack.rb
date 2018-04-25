module Notification
  class EndStack < Base
    def initialize(player:, opponent:, turn:)
      @player = player
      @opponent = opponent
      @turn = turn
    end

    def messages
      opponent.devices.map do |device|
        {
          to: device.expo_token,
          body: "#{player.name} ended the stack with #{turn.answer}",
          sound: "default"
        }
      end
    end

    private

    attr_reader :player, :opponent, :turn
  end
end
