require 'spec_helper'

feature 'you edit your profile' do
  scenario 'changing your name, username, and email' do
    you = create(:user)
    ux = ProfileExperience.new(you)
    ux.edit

    ux.should have_edited_profile
    ux.should have_emailed_update
  end
end
