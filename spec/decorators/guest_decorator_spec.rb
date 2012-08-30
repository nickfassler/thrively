require 'spec_helper'

describe GuestDecorator do
  describe '#link_to_profile' do
    it 'does not generate a link to profile for guest' do
      decorator = GuestDecorator.new(create(:guest))
      decorator.link_to_profile.should == decorator.model.email
    end
  end
end
