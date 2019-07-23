class ApplicationController < ActionController::Base
  include SessionsHelper

  def check_is_admin_permission
    return if logged_in? && current_user.is_admin?
    flash[:danger] = t "not_permission"
    redirect_to root_path
  end

  def check_is_logged_in
    return if logged_in?
    flash[:danger] = t "not_loggin"
    redirect_to login_path
  end
end
