require 'spec_helper'

feature 'you request feedback' do
  scenario 'from welcome page' do
    you = create(:user)
    ux = RequestFeedbackExperience.new(you)
    ux.request_feedback

    ux.should have_requested_feedback
    ux.should have_delivered_request_to_friend
  end
end
