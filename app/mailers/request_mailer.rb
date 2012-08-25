class RequestMailer < ActionMailer::Base
  default from: 'noreply@thrive.ly'

  def new_request(request)
    @message = request.message
    mail(to: request.requested_feedbacks.map(&:giver_email), subject: request.subject)
  end
end
