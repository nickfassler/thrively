class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new(params[:feedback])
    @feedback.receiver = User.where(id: params[:user_id]).first
    @receiver_provided = @feedback.receiver.present?
  end

  def create
    @feedback = Feedback.new(params[:feedback])

    if current_user
      @feedback.giver = current_user
    end

    if @feedback.save
      Mailer.feedback_given(@feedback).deliver
      redirect_to root_path, flash: { success: 'Feedback was successful' }
    else
      @receiver_provided = params[:receiver_provided]
      flash.now[:error] = 'There is an error in your input'
      render action: 'new'
    end
  end
end
