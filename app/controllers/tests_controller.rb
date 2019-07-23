class TestsController < ApplicationController
  before_action :check_is_admin_permission

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

  def index
    @tests = Test.all
    if current_user.is_admin?
      render "tests/admin/index"
    end
  end

  private
  def test_params
    params.require(:test).permit :name, :kind, :time
  end
end
