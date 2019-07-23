class UsersController < ApplicationController
  before_action :check_is_admin_permission
  before_action :set_user, only: [:show]

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @results = @user.results.includes(:test)
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
  def set_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".user_not_be_found"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
