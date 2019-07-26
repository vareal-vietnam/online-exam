class QuestionsController < ApplicationController
  before_action :get_test, only: [:new, :create, :add]

  def new
    @question = Question.new test: @test
  end

  def create
    error = false
    a = params[:content].count
    a.times do |n|
      @question = Question.new
      @question.test = @test
      @question.content = params[:content][n]
      if @question.save
        params[:answer][n].each do |key, value|
          @answer = Answer.new
          @answer.question = @question
          @answer.content = value
          @answer.is_correct =true if params[:correct][n] == key
          error = true unless @answer.save
        end
      else
        error = true
      end
    end
    if error
      flash[:danger] = t ".error_create"
    else
      flash[:success] = t "success_create", for_object: "Question"
    end
    redirect_to root_path
  end

  def add
    @question = Question.new test: @test
    if @question
      render json: {html: render_to_string(partial: "question")}
    end
  end

  private
  def question_params
    params.require(:qs).permit :test_id, :content
  end

  def get_test
    @test = Test.find_by id: params[:id_question]
    unless @test
      flash[:danger] = t "error_404"
      redirect_to root_path
    end
  end
end
