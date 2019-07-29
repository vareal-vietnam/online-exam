class QuestionsController < ApplicationController
  before_action :get_question

  def destroy
    @question.destroy
    flash[:success] = t ".question_deleted"
    redirect_to test_path @question.test
  end

  private
  def get_question
    @question = Question.find_by id: params[:id]
  end
end
