require 'spec_helper'

feature 'you invite friend' do
  scenario 'and you have remaining invites' do
    you = create(:user, remaining_invites: 1)
    ux = InviteExperience.new(you)
    ux.invite
    ux.sign_out

    ux.should have_invited_friend

    friend_ux = AcceptExperience.new
    friend_ux.accept

    friend_ux.should have_accepted_invite
  end

  scenario 'but you have no remaining invites' do
    you = create(:user, remaining_invites: 0)
    ux = InviteExperience.new(you)

    ux.should_not be_possible
  end
end
