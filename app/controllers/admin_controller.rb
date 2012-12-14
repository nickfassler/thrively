class AdminController < ApplicationController
  before_filter :authorize_as_admin

  layout 'admin'

  protected

  def authorize_as_admin
    unless signed_in? && current_user.admin?
      redirect_to sign_in_path
    end
  end
end
