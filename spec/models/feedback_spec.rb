require 'spec_helper'

describe Feedback do
  it { should allow_mass_assignment_of(:subject) }
  it { should allow_mass_assignment_of(:plus) }
  it { should allow_mass_assignment_of(:delta) }
  it { should_not allow_mass_assignment_of(:giver_id) }
  it { should_not allow_mass_assignment_of(:receiver_id) }
end
