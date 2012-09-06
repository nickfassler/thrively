class UsersController < Clearance::UsersController
  before_filter :authorize, only: [:show, :edit, :update]

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      @invite = @user.invite
      render template: 'accepts/show'
    end
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to current_user, flash: { success: 'Profile was successfully updated' }
    else
      flash.now[:error] = 'There is an error in your input'
      render action: 'edit'
    end
  end
end
