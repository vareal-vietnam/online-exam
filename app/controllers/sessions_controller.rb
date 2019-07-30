class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_to root_path
      else
        message  = t ".account_not_activated"
        message += t ".check_your_email"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".invalid"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
