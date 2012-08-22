require 'spec_helper'

describe RequestedFeedback do
  it { should validate_presence_of(:email) }
  it { should_not validate_format_of(:email).with('user@example') }
  it { should validate_format_of(:email).with('user@example.com') }
end
