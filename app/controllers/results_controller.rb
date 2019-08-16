class ResultsController < ApplicationController
  before_action :get_result, only: %i[show update destroy]
  before_action :get_test, only: %i[update index destroy]
  before_action :check_double_submit, only: %i[update]
  before_action :params_answers, only: %i[update]
  before_action :check_is_logged_in, :check_is_admin_permission,
                only: %i[index destroy]

  def show
    @test = @result.test
    @questions = @test.questions.includes :answers
  end

  def update
    unless @params_answers[:answers].nil?
      @params_answers[:answers].each do |answer|
        save_result_answer answer, @result
      end
      update_result @result
    end
    flash[:success] = t '.result', score: @result.score
    redirect_to test_result_path(@test, @result)
  end

  def index
    @results = @test.results.includes :user
    @results = @results.paginate(page: params[:page])
  end

  def destroy
    @result.destroy
    flash[:success] = t '.success_delete', for_object: 'Test'
    redirect_to test_results_path @test
  end

  private

  def get_test
    @test = Test.find_by id: params[:test_id]
    return if @test

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end

  def get_result
    @result = Result.find_by id: params[:id]
    return if @result

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end

  def save_result_answer(answer, result)
    @result_answer = ResultAnswer.create(answer_id: answer, result: result)
  end

  def update_result(result)
    score = result.result_answers.inject(0) do |count, result_answer|
      count += 1 if result_answer.answer.is_correct?
      count
    end
    result.update_attribute :score, score
  end

  def params_answers
    @params_answers = params.permit(answers: [])
  end

  def check_double_submit
    return unless @result.result_answers.count.positive?

    flash[:info] = t '.submited'
    redirect_to test_result_path(@test, @result)
  end
end
