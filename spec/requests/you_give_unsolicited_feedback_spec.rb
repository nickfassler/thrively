require 'spec_helper'

feature 'you give unsolicited feedback' do
  scenario 'before requesting feedback' do
    you = create(:user)
    ux = GiveUnsolicitedFeedbackExperience.new(you)

    ux.should_not be_possible
  end

  scenario 'after requesting feedback' do
    you = create(:user)
    create(:request, user: you)
    ux = GiveUnsolicitedFeedbackExperience.new(you)
    ux.give_feedback

    ux.should have_given_feedback
  end
end
