require 'spec_helper'

feature 'you sign in' do
  scenario 'and see the welcome page' do
    you = create(:user)
    ux = SignInExperience.new(you)
    ux.sign_in

    ux.should be_welcomed
  end

  scenario 'and see your activity stream' do
    you = create(:user)
    create(:request, user: you)
    ux = SignInExperience.new(you)
    ux.sign_in

    ux.should have_activities
  end
end
