FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :name do |n|
    "Test User #{n}"
  end

  sequence :username do |n|
    "user#{n}"
  end

  factory :feedback do
    association :receiver, factory: :user
    association :giver, factory: :user

    topic 'Feedback for test'
    plus  'Good job'
    delta 'Improve your specs'
  end

  factory :guest do
    email
  end

  factory :history_event do
    association :owner, factory: :user
    association :resource, factory: :feedback
  end

  factory :invite do
    email
    user
  end

  factory :request do
    user

    topic 'Please provide feedback'
    message 'Dear friend, I would like your feedback'

    after(:build) do |request|
      if request.requested_feedbacks.empty?
        request.requested_feedbacks = [build(:requested_feedback, request: request)]
      end
    end
  end

  factory :requested_feedback do
    association :giver, factory: :user
    request
  end

  factory :user do
    email
    name
    username

    password 'password'
  end
end
