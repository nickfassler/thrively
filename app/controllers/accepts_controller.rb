class AcceptsController < ApplicationController
  def show
    @user = User.new
    @invite = Invite.where(token: params[:invite]).first!
  end
end
