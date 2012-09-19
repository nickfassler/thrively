class DashboardsController < ApplicationController
  before_filter :authorize

  def show
    @events = current_user.stream.page(params[:page])
  end
end
