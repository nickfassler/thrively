require 'spec_helper'

feature 'friend accepts invite' do
  scenario 'and previously gave feedback as a guest' do
    friend = create(:guest)
    create(:feedback, giver: friend)
    create(:invite, email: friend.email)
    ux = AcceptExperience.new
    ux.accept

    ux.should have_accepted_invite
  end

  scenario 'and previously receieved feedback as a guest' do
    friend = create(:guest)
    create(:feedback, receiver: friend)
    create(:invite, email: friend.email)
    ux = AcceptExperience.new
    ux.accept

    ux.should have_accepted_invite
  end
end
