require 'spec_helper'

feature 'Accept invite' do
  scenario 'from user with remaining invites' do
    user = create(:user, remaining_invites: 1)
    friend_email = 'friend@example.com'
    visit root_path(as: user)
    invite_friend(user, friend_email)
    received_invite?(user, friend_email)
    accept_invite(Invite.last)
    viewing_welcome?
  end

  scenario 'user types invalid email' do
    user = create(:user, remaining_invites: 1)
    visit root_path(as: user)
    invite_friend_with_invalid_email(user)
    invalid_email?
  end

  scenario 'from user without remaining invites' do
    user = create(:user, remaining_invites: 0)
    friend_email = 'friend@example.com'
    visit root_path(as: user)
    cannot_invite?
  end

  scenario 'user does not fill in required fields' do
    user = create(:user, remaining_invites: 1)
    visit root_path(as: user)
    invite_friend(user, 'friend@example.com')
    accept_invite_without_username(Invite.last)

    within('.username') do
      page.should have_content("can't be blank")
    end

    accept_invite_without_name(Invite.last)

    within('.name') do
      page.should have_content("can't be blank")
    end
  end

  scenario 'to a guest with prior feedbacks' do
    guest_name = create(:guest)
    friend = create(:user)
    given_feedback = create(:feedback, giver: guest_name)
    received_feedback = create(:feedback, receiver: guest_name)
    invite = create(:invite, email: guest_name.email)
    accept_invite(invite)
    viewing_welcome?
  end

  private

  def invite_friend(user, friend_email)
    click_link 'Invite a friend'
    fill_in 'Email', with: friend_email
    click_button 'Invite'
    click_link 'Sign out'
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

  def viewing_welcome?
    page.should have_content('Get started with Thrively')
  end

  def cannot_invite?
    page.should_not have_content('Invite a friend')
  end

  def invalid_email?
    within('.email') do
      page.should have_content('is not an email')
    end
  end
end
