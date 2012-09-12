require 'spec_helper'

feature 'Dashboard' do
  scenario 'User can see their activity stream on the dasboard' do
    you = create(:user)
    friend = create(:user)
    received_feedback = create(:feedback, receiver: you, giver: friend)
    given_feedback = create(:feedback, receiver: friend, giver: you)
    request_from = create(:request, user: you, emails: [friend.email])
    request_to = create(:request, user: friend, emails: [you.email])

    sign_in_as you

    within '.feedback.received' do
      page.should have_content("#{friend.name} gave feedback to you")
      page.should have_content(received_feedback.topic)
      page.should have_content(received_feedback.plus)
      page.should have_content(received_feedback.delta)
    end

    within '.feedback.sent' do
      page.should have_content("You gave feedback to #{friend.name}")
      page.should have_content(given_feedback.topic)
      page.should_not have_content(given_feedback.plus)
      page.should_not have_content(given_feedback.delta)
    end

    within '.request.sent' do
      page.should have_content("You requested feedback from #{friend.name}")
      page.should have_content(request_from.topic)
      page.should_not have_content(request_from.message)
    end

    within '.request.received' do
      page.should have_content("#{friend.name} requested feedback from you")
      page.should have_content(request_to.topic)
      page.should have_content(request_to.message)
    end
  end

  scenario 'User can click on next and previous pages to see more activity' do
    you = create(:user)
    friend = create(:user)
    create(:feedback, receiver: you, giver: friend)
    create(:feedback, receiver: friend, giver: you)
    HistoryEvent.per_page = 1

    sign_in_as you
    click_link('2')

    page.should have_content("#{friend.name} gave feedback to you")

    click_link('1')

    page.should have_content("You gave feedback to #{friend.name}")
  end
end
