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
    association :giver, factory: :user
    association :receiver, factory: :user

    delta 'Improve your specs'
    plus  'Good job'
    topic 'Feedback for test'
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

    message 'Dear friend, I would like your feedback'
    topic 'Please provide feedback'

    after :build do |request|
      if request.requested_feedbacks.empty?
        request.requested_feedbacks = [build(:requested_feedback, request: request)]
      end
    end

    factory :request_without_requested_feedbacks do |request|
      after :build do |request|
        request.requested_feedbacks = []
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

    factory :admin do |user|
      admin true
    end
  end
end
