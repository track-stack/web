# Serializes an instance of StackWinner

class StackWinnerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :user_id, :stack_id, :score
end
