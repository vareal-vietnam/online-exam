class AccountActivationsController < ApplicationController

  def edit
    email_param = {email: params[:email]}
    user = User.find_by email_param
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = t ".account_activated!"
      redirect_to login_path
    else
      flash[:danger] = t ".invalid_activation_link"
      redirect_to login_path
    end
  end
end
