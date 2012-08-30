require 'spec_helper'

describe UserDecorator do
  describe '#link_to_profile' do
    it 'generates a link to profile for user' do
      decorator = UserDecorator.new(create(:user))
      decorator.link_to_profile.should =~ /\/feedbacks\/new\?user_id=\d+/
    end
  end
end
