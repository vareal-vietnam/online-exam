class ResultsController < ApplicationController
  before_action :get_test, :save_result, only: %i[create]

  def create
    params[:questions].each do |answer|
      save_result_answer answer, @result
    end
    update_result @result
    flash[:success] = t '.result', score: @result.score
    redirect_to root_path
  end

  private

  def get_test
    @test = Test.find_by id: params[:test_id]
    return @test if @test

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end

  def save_result
    @result = Result.new
    @result.user = current_user
    @result.test = @test
    @result.save
  end

  def save_result_answer(answer, result)
    @result_answer = ResultAnswer.new
    @result_answer.answer_id = answer
    @result_answer.result = result
    @result_answer.save
  end

  def update_result(result)
    count = 0
    result.result_answers.each do |result_answer|
      count += 1 if result_answer.answer.is_correct?
    end
    result.update_attribute :score, count
  end
end
