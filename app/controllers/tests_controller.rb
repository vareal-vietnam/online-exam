class TestsController < ApplicationController
  before_action :check_is_logged_in
  before_action :set_test
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
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find_by id: params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:name)
    end
end
