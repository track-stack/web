FactoryGirl.define do
  factory :turn do
    user_id 1
    game_id 1
    answer { Faker::Music.instrument }
  end
end
