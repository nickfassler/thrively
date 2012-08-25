require 'spec_helper'

describe Feedback do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:giver_id) }
  it { should_not allow_mass_assignment_of(:receiver_id) }

  it { should validate_presence_of(:receiver_id) }
  it { should validate_presence_of(:giver_id) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:plus) }
  it { should validate_presence_of(:delta) }
end
