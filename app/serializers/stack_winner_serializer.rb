class StackWinnerSerializer
  include FastJsonapi::ObjectSerializer

  attributes :user_id, :stack_id, :score
end
