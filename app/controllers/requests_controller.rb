class RequestsController < ApplicationController
  before_filter :authorize

  def new
    @request = Request.new
    @request.requested_feedbacks.build
  end

  def create
    @request = Request.new(params[:request])

    if @request.save
      flash[:success] = 'Feedback request sent successfully'
      redirect_to dashboard_path
    else
      flash[:error] = 'An error prevented this request form being sent'
      render action: 'new'
    end
  end
end
