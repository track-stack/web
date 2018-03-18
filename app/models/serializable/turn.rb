module Serializable
  class Track
    delegate :id, :user_id, :answer, :created_at, :match, to: :track

    def initialize(track)
      @track = track
    end

    private

    attr_reader :track
  end
end
