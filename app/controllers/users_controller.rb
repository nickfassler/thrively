class UsersController < Clearance::UsersController
  before_filter :authorize, only: [:show, :edit, :update]
  respond_to :html, :json

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
    results = current_user.friends_emails

    unless params[:term].empty? || params[:term].nil?
      results.select! { |email| email.include? params[:term]}
    end

    respond_with results.map! { |email| { value: email } }
  end
end
