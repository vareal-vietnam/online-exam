class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      check_account_active(user)
    else
      flash.now[:danger] = t '.invalid'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def check_account_active(user)
    if user.activated?
      log_in user
    else
      message  = t '.account_not_activated'
      message += t '.check_your_email'
      flash[:warning] = message
    end
    redirect_to root_path
  end
end
