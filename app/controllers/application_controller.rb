class ApplicationController < ActionController::Base
  protect_from_forgery


  private

  def require_login
  	redirect_to signup_login_path unless current_user
  end	


end
