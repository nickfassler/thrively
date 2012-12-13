class ProfileExperience < Experience
  def initialize(you)
    @you = you
  end

  def edit
    visit edit_user_path(@you, as: @you)
    fill_in 'Name', with: 'Edited User'
    fill_in 'Username', with: 'test_user'
    fill_in 'Email', with: 'edited_user@example.com'
    click_button 'Save'
  end

  def has_edited_profile?
    current_path == user_path(@you) &&
      page.has_content?('Profile was successfully updated') &&
      page.has_content?('Edited User') &&
      page.has_content?('test_user') &&
      page.has_content?('edited_user@example.com')
  end

  def has_emailed_update?
    last_sent_email.to.include?('edited_user@example.com') &&
      last_sent_email.subject.include?('Your updated settings')
  end
end
