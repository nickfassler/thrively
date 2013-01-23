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
      render action: 'edit'
    end
  end

  def friends_autocomplete
    @friends_email = FriendsEmail.all
    respond_to do |format|
      format.json { render :json => @friends_email }
    end
  end
end
