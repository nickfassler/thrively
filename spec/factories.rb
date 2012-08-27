FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :guest do
    email
  end

  factory :request do
    user

    subject 'Please provide feedback'
    message 'Dear friend, I would like your feedback'
  end

  factory :user do
    email
    password 'password'
  end
end
