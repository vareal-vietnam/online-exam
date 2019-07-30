class UsersController < ApplicationController
  #before_action :check_is_logged_in, :check_is_admin_permission
  before_action :get_user, only: [:edit, :update, :destroy, :show]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.validate
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to login_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success_update"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".success_delete"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def get_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "error_404"
      redirect_to root_path
    end
  end
end
