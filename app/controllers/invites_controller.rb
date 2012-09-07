class InvitesController < ApplicationController
  before_filter :authorize

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(params[:invite])
    @invite.user = current_user

    if @invite.save
      redirect_to root_path
    else
      render :new
    end
  end
end
