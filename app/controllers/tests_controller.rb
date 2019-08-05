class TestsController < ApplicationController
  array_method = %i[new create edit update destroy]

  before_action :check_is_logged_in, except: %i[index]
  before_action :check_is_admin_permission, only: array_method
  before_action :get_test, only: %i[show edit update destroy mark]
  before_action :save_result, only: %i[mark]

  def index
    @tests = Test.all
    render 'tests/admin/index' if current_user&.is_admin?
  end

  def show
    @questions = @test.questions.includes :answers
    @questions = @questions.paginate(page: params[:page],
                        per_page: Settings.per_page_questions)
    render 'tests/admin/show' if current_user.is_admin?
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new test_params
    if @test.save
      flash[:success] = t 'success_create', for_object: 'Test'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @test.update_attributes(test_params)
      flash[:success] = t 'success_update', for_object: 'Test'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @test.destroy
    flash[:success] = t '.success_delete', for_object: 'Test'
    redirect_to root_path
  end

  def mark
    params[:questions].each do |answer|
      save_result_answer answer, @result
    end
    update_result @result
    flash[:success] = t '.result', score: @result.score
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
    test_attributes = [:name, :kind, :time,
                       questions_attributes:
                         [:id, :content, :_destroy, \
                          answers_attributes:
                            %i[id is_correct content _destroy]]]
    params.require(:test).permit(test_attributes)
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
