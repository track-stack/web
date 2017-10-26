FactoryGirl.define do
  factory :turn do
    user_id 1
    game_id 1
    answer { Faker::Music.instrument }
    distance 0
    match { { name: Faker::Name.name, artist: Faker::Name.name, image: "http://image.png" } }
  end
end
