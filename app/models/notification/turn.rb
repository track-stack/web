class Notification::Turn
  def initialize(player:, opponent:)
    @player = player
    @opponent = opponent
  end

  def send
    valid = messages.reject { |m| m[:to].nil? }
    return if valid.empty?
    client.publish valid
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
