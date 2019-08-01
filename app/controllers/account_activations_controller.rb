class AccountActivationsController < ApplicationController
  before_action :active_account, only: %i[edit]
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      active_account
    else
      flash[:danger] = t '.invalid_activation_link'
      redirect_to login_path
    end
  end

  private

  def active_account
    user.update_attribute(:activated, true)
    user.update_attribute(:activated_at, Time.zone.now)
    log_in user
    flash[:success] = t '.account_activated'
    redirect_to root_path
  end
end
