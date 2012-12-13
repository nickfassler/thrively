require 'spec_helper'

feature 'you view activities' do
  scenario 'on activity stream' do
    you = create(:user)
    ux = ActivityExperience.new(you)
    ux.you_request_feedback_from_friend
    ux.friend_requests_feedback_from_you
    ux.you_view_activity_stream

    ux.should have_pending_request_from_you
    ux.should have_pending_request_to_you

    ux.friend_gives_you_feedback
    ux.you_give_feedback_to_friend
    ux.you_view_activity_stream

    ux.should have_no_pending_requests
    ux.should have_feedback_from_friend_to_you
    ux.should have_feedback_from_you_to_friend
  end

  scenario 'on next and previous pages' do
    you = create(:user)
    ux = ActivityExperience.new(you, per_page: 1)
    ux.friend_gives_you_feedback
    ux.you_request_feedback_from_friend
    ux.you_view_activity_stream

    ux.should have_pending_request_from_you

    ux.you_view_page(2)

    ux.should have_feedback_from_friend_to_you
  end
end
