class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:session][:email]
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t ".success_login"
      redirect_to root_url
    else
      flash.now[:danger] = t ".error_login"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
