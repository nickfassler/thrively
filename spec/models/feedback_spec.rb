require 'spec_helper'

describe Feedback do
  it { should allow_mass_assignment_of(:subject) }
  it { should allow_mass_assignment_of(:plus) }
  it { should allow_mass_assignment_of(:delta) }
  it { should_not allow_mass_assignment_of(:giver_id) }
  it { should_not allow_mass_assignment_of(:receiver_id) }
  it { should validate_presence_of(:receiver) }
  it { should validate_presence_of(:giver) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:plus) }
  it { should validate_presence_of(:delta) }
end
