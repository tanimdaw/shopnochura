class ApplicationController < ActionController::Base
  protect_from_forgery


  private

  def not_authenticated
  	# redirect_to signup_login_path unless current_user
    redirect_to signup_login_path, :notice => "First log in to view this page."
  end

  


end
