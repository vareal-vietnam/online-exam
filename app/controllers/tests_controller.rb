class TestsController < ApplicationController
  before_action :check_is_logged_in
  before_action :get_test, only: [:show]

  def index
    @tests = Test.all
    if current_user.is_admin?
      render "tests/admin/index"
    end
  end
  def show
    @questions = @test.questions
    @name = @test.name
    @time = @test.time
  end

  private
    def get_test
      @test = Test.find_by id: params[:id]
      unless @user
        flash[:danger] = t "error_404"
        redirect_to root_path
      end
    end

    def test_params
      params.require(:test).permit(:name)
    end
end
