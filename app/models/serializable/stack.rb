module Serializable
  class Stack
    delegate :id, to: :stack

    def initialize(stack)
      @stack = stack
    end

    def turns
      stack.turns.map do |turn|
        hash = TurnSerializer.new(turn).to_hash
        hash[:data][:attributes]
      end
    end

    def winner
      stack.winner
    end

    def can_end
      stack.can_end?
    end

    def ended
      stack.ended_at.present?
    end

    private

    attr_reader :stack
  end
end

