require 'spec_helper'

describe RequestedFeedback do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:request_id) }

  it { should validate_presence_of(:giver) }
end
