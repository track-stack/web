class Notification::Turn
  def initialize(player:, opponent:)
    @player = player
    @opponent = opponent
  end

  def send
    client.publish messages
  end

  private

  def messages
    @opponent.devices.map do |device|
      {
        to: device.expo_token,
        body: "Your turn against #{@player.name}",
        sound: "default"
      }
    end
  end

  def client
    @client ||= Exponent::Push::Client.new
  end
end
