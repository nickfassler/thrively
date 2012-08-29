class DashboardsController < ApplicationController
  before_filter :authorize

  def show
    @events = HistoryEventDecorator.decorate(current_user.stream_events)
  end
end