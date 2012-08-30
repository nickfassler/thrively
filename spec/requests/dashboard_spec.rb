require 'spec_helper'

feature 'Dashboard' do
  scenario 'User can see their activity stream on the dasboard' do
    user = create(:user)
    user2 = create(:user)
    received_feedback = create(:feedback, receiver: user, giver: user2)
    given_feedback = create(:feedback, receiver: user2, giver: user)
    request_from = create(:request, user: user, emails: { '0' => user2.email })
    request_to = create(:request, user: user2, emails: { '0' => user.email })

    sign_in_as user

    within '.feedback.received' do
      page.should have_content("from #{user2.email}")
      page.should have_content(received_feedback.topic)
      page.should have_content(received_feedback.plus)
      page.should have_content(received_feedback.delta)
    end

    within '.feedback.sent' do
      page.should have_content("to #{user2.email}")
      page.should have_content(given_feedback.topic)
      page.should have_content(given_feedback.plus)
      page.should have_content(given_feedback.delta)
    end

    within '.request.sent' do
      page.should have_content("from: #{user2.email}")
      page.should have_content(request_from.topic)
    end

    within '.request.received' do
      page.should have_content("from #{user2.email}")
      page.should have_content(request_to.topic)
    end
  end
end
