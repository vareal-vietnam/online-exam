class TestsController < ApplicationController
  before_action :check_is_logged_in, only: %i[index new create]
  before_action :check_is_admin_permission, only: %i[new create destroy]
  before_action :get_test, only: %i[show destroy update edit]

  def index
    @tests = Test.all
    # render 'tests/admin/index' if current_user.is_admin?
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def create
    @test = Test.new test_params
    if @test.save
      flash[:success] = t '.success_create'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @test.update_attributes(test_params)
      flash[:success] = t 'success_update'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @questions = @test.questions.includes :answers
  end

  def destroy
    @test.destroy
    flash[:success] = t '.success_delete'
    redirect_to root_path
  end

  private

  def get_test
    @test = Test.find_by id: params[:id]
    return @test if @test

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end

  def test_params
    params.require(:test).permit(:name, :kind, :time)
  end
end
