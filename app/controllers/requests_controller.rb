class RequestsController < ApplicationController
  before_filter :authorize

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request].update(emails: params[:emails]))
    @request.user_id = current_user.id

    if @request.save
      @request.requested_feedbacks.includes(:request, :giver).each(&:notify)

      redirect_to dashboard_path,
        flash: { success: 'Feedback request sent successfully' }
    else
      flash.now[:error] = 'There is an error in your input'
      render action: 'new'
    end
  end
end
