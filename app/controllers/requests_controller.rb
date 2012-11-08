class RequestsController < ApplicationController
  before_filter :authorize

  def new
    @request = Request.new
    @friends_emails = current_user.friends_emails
  end

  def create
    @request = Request.new(params[:request])
    @request.user_id = current_user.id
    @request.requested_feedbacks.each { |requested_feedback| requested_feedback.hash_id = requested_feedback.generate_hash }

    if @request.save
      redirect_to dashboard_path,
        flash: { success: 'Your feedback request was sent successfully' }
    else
      render action: 'new'
    end
  end
end
