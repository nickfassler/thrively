require 'spec_helper'

feature 'you sign in' do
  scenario 'and see the welcome page' do
    user = create(:user)
    ux = SignInExperience.new(user)
    ux.sign_in

    ux.should be_welcomed
  end

  scenario 'and see your activity stream' do
    user = create(:user)
    create(:request, user: user)
    ux = SignInExperience.new(user)
    ux.sign_in

    ux.should have_activities
  end
end
