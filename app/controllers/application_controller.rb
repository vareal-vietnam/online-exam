class ApplicationController < ActionController::Base
  include SessionsHelper

  def check_is_admin_permission
    return if logged_in? && current_user.is_admin?
    flash[:danger] = t "error_403"
    redirect_to root_path
  end
end
