FactoryGirl.define do
  factory :user do
    email "email@example.god"
    password "password"
  end

  trait :facebook do
    uid "10210079980532082"
    oauth_token "EAABz2celF1wBAADMBTpQNNWjTJcY5ceZC2TNTx9T1feMQzp6QxPKJZAf60BAirHhVZAKu4c4SUpGADVxxD29Lm7fIyujgq5B96uSp8alQZCfD4yZCO1rdViclCZBwbh1bzO7kcbG4wcAruKC915WNf9YZC1FbcZC56Xkwx1EDctl7ZA1NJvUPwII5"
  end
end
