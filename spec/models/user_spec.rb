require 'spec_helper'

describe User do
  describe '#display_name' do
    it 'returns email if user does not have first or last names' do
      user = create(:user)

      user.display_name.should == user.email
    end

    it 'returns first name if user does not have last name' do
      user = create(:user, first_name: 'Bob')

      user.display_name.should == user.first_name
    end

    it 'returns last name if user does not have first name' do
      user = create(:user, last_name: 'Wilson')

      user.display_name.should == user.last_name
    end

    it 'returns last name if user does not have first name' do
      user = create(:user, first_name: 'Bob', last_name: 'Wilson')

      user.display_name.should == 'Bob Wilson'
    end
  end
end
