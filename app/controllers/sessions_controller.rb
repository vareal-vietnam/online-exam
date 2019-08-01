class SessionsController < ApplicationController
  befor_action :get_user, only: %i[create]

  def new
  end

  def create
    if @user&.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = t '.success_login'
      redirect_to root_path
    else
      flash.now[:danger] = t '.error_login'
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
end
