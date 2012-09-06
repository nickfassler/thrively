require 'spec_helper'

describe RequestDecorator do
  describe '#header' do
    it "contains requester's email link in invitee's stream" do
      request = create(:request)
      invitee = request.requested_feedbacks.first.giver
      decorator = RequestDecorator.new(request)
      decorator.header(invitee).should =~ regex_for_link(request.user_name)
    end

    it "contains invitee's email in requester's stream" do
      request = create(:request)
      invitee = request.requested_feedbacks.first.giver
      decorator = RequestDecorator.new(request)
      decorator.header(request.user).should =~ regex_for_link(invitee.name)
    end
  end
end
