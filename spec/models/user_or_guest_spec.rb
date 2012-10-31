require 'spec_helper'

describe UserOrGuest do
  describe '#initialize' do
    it 'downcases the email' do
      email = 'Guest@example.com'
      user_or_guest = UserOrGuest.new(email)
      user_or_guest.email.should == 'guest@example.com'
    end
  end

  describe '#find' do
    it 'finds user for existing user email' do
      user = create(:user)
      user_or_guest = UserOrGuest.new(user.email)

      result = user_or_guest.find

      result.should == user
    end

    it 'finds guest existing guest email' do
      guest = create(:guest)
      user_or_guest = UserOrGuest.new(guest.email)

      result = user_or_guest.find

      result.should == guest
    end

    it 'initializes a guest for never seen email' do
      user_or_guest = UserOrGuest.new('new@example.com')

      result = user_or_guest.find

      result.should be_a Guest
    end
  end
end
