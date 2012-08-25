class RequestsController < ApplicationController
  before_filter :authorize

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params[:request].update(emails: params[:emails]))
    @request.user_id = current_user.id

    if @request.save
      RequestMailer.new_request(@request).deliver
      redirect_to dashboard_path,
        flash: { success: 'Feedback request sent successfully' }
    else
      flash.now[:error] = 'There is an error in your input'
      render action: 'new'
    end
  end
end
