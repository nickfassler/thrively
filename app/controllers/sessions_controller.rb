class SessionsController < Clearance::SessionsController
  private

  def flash_failure_after_create
    flash.now[:notice] = 'Bad email or password'
  end
end
