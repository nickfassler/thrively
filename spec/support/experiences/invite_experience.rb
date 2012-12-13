class InviteExperience < Experience
  def initialize(you)
    @you = you
    @friend_email = 'friend@example.com'
  end

  def invite
    visit new_invite_url(as: @you)
    fill_in 'Email', with: @friend_email
    click_button 'Invite'
  end

  def has_invited_friend?
    from_support? &&
      reply_to_user? &&
      to_friend? &&
      body_includes_url_to_accept?
  end

  def possible?
    visit root_path(as: @you)
    page.has_content?('Invite a friend')
  end

  private

  def from_support?
    last_sent_email.from.include?(Mailer::SUPPORT_ADDRESS)
  end

  def reply_to_user?
    last_sent_email.reply_to.include?(@you.email)
  end

  def to_friend?
    last_sent_email.to.include?(@friend_email)
  end

  def body_includes_url_to_accept?
    last_sent_email_body.include?(accept_url(invite: Invite.last.token))
  end
end
