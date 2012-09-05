class UsersController < ApplicationController
  before_filter :authorize

  def update
    if current_user.update_attributes(params[:user])
      redirect_to current_user, flash: { success: 'Profile was successfully updated' }
    else
      flash.now[:error] = 'There is an error in your input'
      render action: 'edit'
    end
  end
end
