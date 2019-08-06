class ResultsController < ApplicationController
  before_action :check_is_logged_in
  before_action :get_result, only: %i[show]

  def show
    @test = @result.test
    @questions = @test.questions.includes :answers
  end

  private

  def get_result
    @result = Result.find_by id: params[:id]
    return @result if @result

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end
end
