class AcceptExperience < Experience
  def initialize
    @invite = Invite.last
  end

  def accept
    click_link_in_invite_email
    fill_in 'Name', with: 'Friend'
    fill_in 'Password', with: 'password'
    fill_in 'Username', with: 'friend'
    click_button 'Sign up'
  end

  def has_accepted_invite?
    page.has_content?('Get started with Thrively')
  end

  private

  def click_link_in_invite_email
    visit accept_url(invite: @invite.token)
  end
end
