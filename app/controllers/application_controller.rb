class ApplicationController < ActionController::Base
  include SessionsHelper

  def check_is_admin_permission
    return if logged_in? && current_user.is_admin?
    flash[:danger] = t "not_permission"
    redirect_to root_path
  end
end
