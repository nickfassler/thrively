class DashboardsController < ApplicationController
  before_filter :authorize

  def show
    @events = current_user.history_events.includes(:resource, :owner).
      page(params[:page])
  end
end
