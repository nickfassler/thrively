class DashboardsController < ApplicationController
  before_filter :authorize, :display_welcome

  def show
    @events = current_user.stream.page(params[:page])
  end

  private

  def display_welcome
    if current_user.requests.empty?
      redirect_to welcome_path
    end
  end
end
