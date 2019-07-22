class UsersController < ApplicationController
  before_action :check_is_admin_permission
  before_action :get_user, only: [:edit, :update, :destroy, :show]

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
    if @user.destroy
      flash[:success] = t ".success_delete"
      redirect_to users_path
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def get_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".error_404"
      redirect_to root_path
    end
  end
end
