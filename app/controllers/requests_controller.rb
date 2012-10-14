class RequestsController < ApplicationController
  before_filter :authorize

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request])
    @request.user_id = current_user.id

    if @request.save
      redirect_to dashboard_path,
        flash: { success: 'Feedback request sent successfully' }
    else
      render action: 'new'
    end
  end
end
