require 'spec_helper'

feature 'UserProfile' do
  scenario 'User can navigate to their profile and see their info' do
    user = create(:user)

    sign_in_as user
    visit user_path(user)

    page.should have_content(user.email)
    page.should have_content(user.first_name)
    page.should have_content(user.last_name)
  end

  scenario 'User can edit their profile info' do
    user = create(:user)

    sign_in_as user
    visit user_path(user)
    click_link 'Edit'
    fill_in 'First name', with: 'Bob'
    fill_in 'Last name', with: 'Wilson'
    click_button 'Save'

    current_path.should == user_path(user)
    page.should have_content('Profile was successfully updated')
    page.should have_content('Bob')
    page.should have_content('Wilson')
  end
end
