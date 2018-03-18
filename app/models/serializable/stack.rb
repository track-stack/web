module Serializable
  class Stack
    delegate :id, :game_id, to: :stack

    def initialize(stack)
      @stack = stack
    end

    def turns
      stack.turns.map do |turn|
        serializable = Serializable::Turn.new(turn)
        hash = TurnSerializer.new(serializable).to_hash
        hash[:data][:attributes]
      end
    end

    def winner
      stack.winner
    end

    def can_end?
      stack.can_end?
    end

    def ended?
      stack.ended?
    end

    private

    attr_reader :stack
  end
end

