class TestsController < ApplicationController
  before_action :check_is_logged_in
  before_action :get_test, only: [:show]
  before_action :check_is_admin_permission, only: [:new, :create]

  def index
    @tests = Test.all
    if current_user.is_admin?
      render "tests/admin/index"
    end
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new test_params
    if @test.save
      flash[:success] = t ".success_create"
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @questions = @test.questions.includes :answers
  end

  private
  def get_test
    @test = Test.find_by id: params[:id]
    unless @test
      flash[:danger] = t "error_404"
      redirect_to root_path
    end
  end

  def test_params
    params.require(:test).permit :name, :kind, :time
  end
end
