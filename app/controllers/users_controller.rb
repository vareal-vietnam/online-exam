class UsersController < ApplicationController
  before_action :check_is_logged_in, exept: %i[new create]
  before_action :check_is_admin_permission, exept: %i[edit_profile]
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
      user_save(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t 'success_update', for_object: 'User'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t 'success_delete', for_object: 'User'
    redirect_to users_path
  end

  def edit_profile
    @user = current_user
    render 'edit'
  end

  private

  def user_params
    user_attributes = %i[name email password password_confirmation]
    params.require(:user).permit user_attributes
  end

  def get_user
    @user = User.find_by id: params[:id]
    return @user if @user

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end

  def user_save(user)
    if current_user&.current_user&.is_admin?
      user.update_attribute(activated: true)
      flash[:success] = t 'success_create', for_object: 'User'
      redirect_to users_path
    else
      UserMailer.account_activation(user).deliver_now
      flash[:info] = t '.check_email'
      redirect_to login_path
    end
  end
end
