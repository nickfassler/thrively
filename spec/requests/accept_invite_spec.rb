require 'spec_helper'

feature 'Accept invite' do
  scenario 'from user with remaining invites' do
    user = create(:user, remaining_invites: 1)
    friend_email = 'friend@example.com'
    sign_in_as(user)

    invite_friend(user, friend_email)

    received_invite?(user, friend_email)

    accept_invite(Invite.last)

    viewing_dashboard?
  end

  scenario 'user types invalid email' do
    user = create(:user, remaining_invites: 1)
    sign_in_as(user)

    invite_friend_with_invalid_email(user)

    invalid_email?
  end

  scenario 'from user without remaining invites' do
    user = create(:user, remaining_invites: 0)
    friend_email = 'friend@example.com'
    sign_in_as(user)

    cannot_invite?
  end

  scenario 'user does not fill in required fields' do
    user = create(:user, remaining_invites: 1)
    sign_in_as(user)
    invite_friend(user, 'friend@example.com')

    accept_invite_without_username(Invite.last)

    page.should have_content("Username can't be blank")

    accept_invite_without_name(Invite.last)

    page.should have_content("Name can't be blank")
  end

  scenario 'when a guest with prior feedbacks' do
    guest = create(:guest)
    feedback1 = create(:feedback, giver: guest, topic: 'Meeting')
    feedback2 = create(:feedback, receiver: guest, topic: 'Intreview')
    invite = create(:invite, email: guest.email)

    accept_invite(invite)

    within('.app-box-content') do
      page.should have_content(feedback1.topic)
      page.should have_content(feedback2.topic)
    end
  end

  private

  def invite_friend(user, friend_email)
    click_link 'Invite a friend'
    fill_in 'Email', with: friend_email
    click_button 'Invite'
    click_link 'Sign out'
    Delayed::Worker.new.work_off
  end

  def invite_friend_with_invalid_email(user)
    click_link 'Invite a friend'
    fill_in 'Email', with: 'invalidemail'
    click_button 'Invite'
  end

  def accept_invite(invite)
    visit accept_url(invite: invite.token)
    fill_in 'Name', with: 'Accepted Invite User'
    fill_in 'Password', with: 'password'
    fill_in 'Username', with: 'accepted-invite-user'
    click_button 'Sign up'
  end

  def accept_invite_without_username(invite)
    visit accept_url(invite: invite.token)
    fill_in 'Name', with: 'Without Username User'
    fill_in 'Password', with: 'password'
    fill_in 'Username', with: ''
    click_button 'Sign up'
  end

  def accept_invite_without_name(invite)
    visit accept_url(invite: invite.token)
    fill_in 'Name', with: ''
    fill_in 'Password', with: 'password'
    fill_in 'Username', with: 'test_user'
    click_button 'Sign up'
  end

  def received_invite?(user, friend_email)
    last_sent_email.from.should include(Mailer::SUPPORT_ADDRESS)
    last_sent_email.reply_to.should include(user.email)
    last_sent_email.to.should include(friend_email)
    last_sent_email_body.should include(accept_url(invite: Invite.last.token))
  end

  def viewing_dashboard?
    page.should have_content('Stream')
  end

  def cannot_invite?
    page.should_not have_content('Invite a friend')
  end

  def invalid_email?
    page.should have_content('Email is not an email')
  end
end
