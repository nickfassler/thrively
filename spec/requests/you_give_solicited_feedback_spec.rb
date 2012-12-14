require 'spec_helper'

feature 'you give solicited feedback' do
  scenario 'to a friend' do
    you = create(:user)
    ux = GiveSolicitedFeedbackExperience.new(you)
    ux.request_feedback
    ux.give_feedback

    ux.should have_given_feedback
    ux.should have_delivered_feedback_to_friend
  end

  scenario 'as a guest' do
    you = create(:guest)
    ux = GiveSolicitedFeedbackExperience.new(you)
    ux.request_feedback
    ux.give_feedback

    ux.should have_given_feedback
    ux.should have_delivered_feedback_to_friend
    ux.should have_delivered_thank_you
    ux.should have_welcomed_you
  end
end
