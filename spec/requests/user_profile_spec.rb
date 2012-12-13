require 'spec_helper'

feature 'UserProfile' do
  scenario 'User can navigate to their profile and see their info' do
    user = create(:user)

    visit root_path(as: user)
    click_link 'Profile'

    page.should have_content(user.email)
    page.should have_content(user.name)
    page.should have_content(user.username)
  end

  scenario 'User can edit their profile info' do
    user = create(:user)

    visit root_path(as: user)
    click_link 'Profile'
    click_link 'Edit'
    fill_in 'Name', with: 'Edited User'
    fill_in 'Username', with: 'test_user'
    click_button 'Save'

    current_path.should == user_path(user)
    page.should have_content('Profile was successfully updated')
    page.should have_content('Edited User')
    page.should have_content('test_user')
  end

  scenario 'User receives an email when changing their email address' do
    user = create(:user)
    reset_email

    visit root_path(as: user)
    click_link 'Profile'
    click_link 'Edit'
    fill_in 'Email', with: 'edited_user@example.com'
    click_button 'Save'

    current_path.should == user_path(user)
    page.should have_content('edited_user@example.com')
    last_sent_email.to.should include('edited_user@example.com')
    last_sent_email.subject.should include('Your updated settings')
  end
end
