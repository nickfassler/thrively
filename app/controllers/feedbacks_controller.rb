class FeedbacksController < ApplicationController
  before_filter :authorize, unless: -> { authorized_as_guest? }

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
      redirect_to root_path, flash: { success: 'Your feedback was sent successfully' }
    else
      @receiver_provided = params[:receiver_provided]
      render action: 'new'
    end
  end

  private

  def authorized_as_guest?
    if params[:feedback]
      guest = Guest.where(email: params[:feedback][:giver_email]).first
      request = Request.where(id: params[:feedback][:request_id]).first

      if request && guest
        request.emails.include?(guest.email)
      end
    end
  end
end
