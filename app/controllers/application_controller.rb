class ApplicationController < ActionController::Base
  include SessionsHelper

  def check_is_admin_permission
    return if current_user.is_admin?

    flash[:danger] = t 'error_403'
    redirect_to root_path
  end

  def check_is_logged_in
    return if logged_in?

    flash[:danger] = t 'not_loggin'
    redirect_to login_path
  end

  alias check_is_admin check_is_admin_permission
end
