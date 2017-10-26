FactoryGirl.define do
  factory :turn do
    answer { Faker::Music.instrument }
    distance 0
    match { { name: Faker::Name.name, artist: Faker::Name.name, image: "http://image.png" } }
  end
end
