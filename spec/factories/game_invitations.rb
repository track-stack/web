FactoryGirl.define do
  factory :game_invitation do
    inviter_id 1
    invitee_id 1
    status 1
  end

  trait :pending do
    status 0
  end

  trait :accepted do
    status 1
  end
end
