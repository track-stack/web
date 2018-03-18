module Serializable
  class Turn
    delegate :id, :user_id, :answer, :created_at, :match, to: :turn

    def initialize(turn)
      @turn = turn
    end

    def user_photo
      turn.user.image
    end

    def has_exact_name_match?
      turn.has_exact_name_match?
    end

    def has_exact_artist_match?
      turn.has_exact_artist_match?
    end

    private

    attr_reader :turn
  end
end
