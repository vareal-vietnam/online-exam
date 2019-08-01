class SessionsController < ApplicationController
  before_action :get_user, only: %i[create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      user_active
    else
      flash.now[:danger] = t '.invalid'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def get_user
    @user = User.find_by email: params[:session][:email]
  end

  def user_active
    if user.activated?
      log_in user
      redirect_to root_path
    else
      message  = t '.account_not_activated'
      message += t '.check_your_email'
      flash[:warning] = message
      redirect_to root_url
    end
  end
end
