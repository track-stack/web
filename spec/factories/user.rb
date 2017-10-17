FactoryGirl.define do
  factory :user do
    email "email@example.god"
    password "password"
  end

  trait :facebook do
    uid "12309875328"
    oauth_token "1089240912ui0912j8012j"
  end
end
