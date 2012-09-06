class AcceptsController < ApplicationController
  def show
    @user = User.new
    @invite = Invite.find_by_token!(params[:invite])
  end
end
