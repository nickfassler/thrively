class RequestedFeedbacksController < ApplicationController
  def show
    requested_feedback = RequestedFeedback.where(id: params[:id]).first!
    redirect_to new_feedback_path(
      feedback: {
        request_id: requested_feedback.request_id,
        giver_email: requested_feedback.giver_email
      }
    )
  end
end
