class UsersController < ApplicationController

  before_action :check_is_logged_in, :check_is_admin_permission, only: [:index, :show, :edit, :update, :destroy]
  before_action :get_user, only: %i[edit update destroy show]

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
      if current_user.nil?
        UserMailer.account_activation(@user).deliver_now
        flash[:info] = t ".check_email"
        redirect_to login_path
      elsif current_user.is_admin?
        @user.update_attributes(activated: true)
        flash[:success] = "success_create"
        redirect_to users_path
      end
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t '.success_update'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t '.success_delete'
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  def get_user
    @user = User.find_by id: params[:id]
    return @user if @user

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end
end
