require 'spec_helper'

describe Guest do
  it { should allow_mass_assignment_of(:email) }
  it { should_not validate_format_of(:email).with('user@example') }
  it { should validate_format_of(:email).with('user@example.com') }
end
