class ResultsController < ApplicationController
  before_action :get_test, :save_result, only: %i[create]

  def create
    params.permit(:answers).each do |answer|
      save_result_answer answer, @result
    end
    update_result @result
    flash[:success] = t '.result', score: @result.score
    redirect_to root_path
  end

  private

  def get_test
    @test = Test.find_by id: params[:test_id]
    return if @test

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end

  def save_result
    @result = Result.create(user: current_user, test: @test)
  end

  def save_result_answer(answer, result)
    @result_answer = ResultAnswer.create(answer_id: answer, result: result)
  end

  def update_result(result)
    count = 0
    result.result_answers.each do |result_answer|
      count += 1 if result_answer.answer.is_correct?
    end
    result.update_attribute :score, count
  end
end
