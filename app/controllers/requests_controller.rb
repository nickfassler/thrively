class RequestsController < ApplicationController
  before_filter :authorize

  def new
    @request = Request.new
    @request.requested_feedbacks.build
  end

  def create
    @request = Request.new(params[:request])
    @request.user_id = current_user.id

    if @request.save
      RequestMailer.new_request(@request).deliver
      redirect_to dashboard_path,
        flash: { success: 'Feedback request sent successfully' }
    else
      flash.now[:error] = 'An error prevented this request form being sent'
      render action: 'new'
    end
  end
end
