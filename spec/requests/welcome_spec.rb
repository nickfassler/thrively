require 'spec_helper'

feature 'Welcome' do
  scenario 'User sees welcome blank slate when first signing in' do
    you = create(:user)
    visit root_path(as: you)
    viewing_welcome?
  end

  scenario 'Guest with feedback sees welcome blank slate when signing up' do
    guest = create(:guest)
    given_feedback = create(:feedback, giver: guest)
    received_feedback = create(:feedback, receiver: guest)
    invite = create(:invite, email: guest.email)
    accept_invite(invite)
    viewing_welcome?
  end

  scenario 'User no longer sees welcome after requesting feedback' do
    you = create(:user)
    friend = create(:user)
    request_from_you = create(:request, user: you, emails: [friend.email])
    visit root_path(as: you)
    viewing_dashboard?
  end

  def viewing_welcome?
    page.should have_content('Get started with Thrively')
  end

  def viewing_dashboard?
    page.should have_content('Stream')
  end

  def accept_invite(invite)
    visit accept_url(invite: invite.token)
    fill_in 'Name', with: 'Accepted Invite User'
    fill_in 'Password', with: 'password'
    fill_in 'Username', with: 'accepted-invite-user'
    click_button 'Sign up'
  end
end
