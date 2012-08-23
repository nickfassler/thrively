require 'spec_helper'

describe RequestMailer do
  describe 'new_request' do
    it 'contructs the email' do
      request = create(:request,
        requested_feedbacks_attributes: [
          { email: 'guest1@example.com' }, { email: 'guest2@example.com' }]
      )
      mail = RequestMailer.new_request(request)

      mail.to.should == ['guest1@example.com', 'guest2@example.com']
      mail.from.should == ['noreply@thrive.ly']
      mail.subject.should == 'Please provide feedback'
      mail.body.should include('Dear friend, I would like your feedback')
    end
  end
end
