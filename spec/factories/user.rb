FactoryGirl.define do
  factory :user do
    email { User.random_email }
    password "password"
  end

  trait :facebook do
    uid "101441640615588"
    oauth_token "EAABz2celF1wBAAnS5EcWtMZCZB84HjklyfEoshS7d1WGWZBqzcNuG3e0jGZAZAOWrc2HkDzPS0SXWMfCI4ChZBwdc0qK34HUIJszZCyQjd4grnayKkLl333ZB8JQmjAoBCFEZC150ffpI93DDyiSFXo9wadABZCr0KyGBWldna2XeVylZBlvCH0bSpz"
  end
end
