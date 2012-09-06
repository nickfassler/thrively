require 'spec_helper'

feature 'Intercom' do
  scenario 'App sends user data to Intercom' do
    user = create(:user)

    sign_in_as user

    page.should have_content('intercom.io')
  end

  scenario 'App does not send visitor data to Intercom' do
    visit root_url
    page.should_not have_content('intercom.io')
  end
end
