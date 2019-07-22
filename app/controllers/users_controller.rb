class UsersController < ApplicationController
  before_action :check_is_admin_permission

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success_create"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find_by id: params[:id]
    unless @user
      flash[:error] = t ".error_404"
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = t ".success_update"
      redirect_to root_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
