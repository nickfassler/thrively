require 'spec_helper'

describe Guest do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

  it {
    should_not validate_format_of(:email).with('user@example').
      with_message(/is not an email/)
  }
  it { should validate_format_of(:email).with('user@example.com') }
end
