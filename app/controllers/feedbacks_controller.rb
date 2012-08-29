class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new(request_id: params[:request_id])
    @feedback.receiver = User.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.giver = current_user

    if @feedback.save
      Mailer.feedback_given(@feedback).deliver
      redirect_to dashboard_path, flash: { success: 'Feedback was successful' }
    else
      flash.now[:error] = 'There is an error in your input'
      render action: 'new'
    end
  end
end