require 'spec_helper'

feature 'UserProfile' do
  scenario 'User can navigate to their profile and see their info' do
    user = create(:user)

    sign_in_as user
    visit user_path(user)

    page.should have_content(user.email)
    page.should have_content(user.name)
    page.should have_content(user.username)
  end

  scenario 'User can edit their profile info' do
    user = create(:user)

    sign_in_as user
    visit user_path(user)
    click_link 'Edit'
    fill_in 'Name', with: 'Edited User'
    fill_in 'Username', with: 'test_user'
    click_button 'Save'

    current_path.should == user_path(user)
    page.should have_content('Profile was successfully updated')
    page.should have_content('Edited User')
    page.should have_content('test_user')
  end
end
