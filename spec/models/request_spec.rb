require 'spec_helper'

describe Request do
  it { should allow_mass_assignment_of(:subject) }
  it { should allow_mass_assignment_of(:message) }
  it { should_not allow_mass_assignment_of(:user_id) }
  it { should allow_value(123).for(:user_id) }
  it { should_not allow_value('abcd').for(:user_id) }
  it { should allow_value([email: 'blah']).for(:requested_feedbacks_attributes) }
  it { should validate_presence_of(:requested_feedbacks) }
end
