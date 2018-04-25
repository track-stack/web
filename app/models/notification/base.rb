module Notification
  class Base
    def send
      valid = messages.reject { |m| m[:to].nil? }
      return if valid.empty?
      client.publish valid
    end

    def messages
      # NOOP
    end

    private

    def client
      @client ||= Exponent::Push::Client.new
    end
  end
end
