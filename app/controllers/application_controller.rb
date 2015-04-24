class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_user_stamp
  	if session[:id]
  		return true
  	else 
  		flash[:notice]="Please login ! "
  		redirect_to(:controller=>'users',:action=>'login')
  		return false
  	end
  end
end
