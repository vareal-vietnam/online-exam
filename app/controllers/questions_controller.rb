class QuestionsController < ApplicationController
  before_action :correct_question, only: :destroy

  def destroy
    @question.destroy
    flash[:success] = t ".question_deleted"
    redirect_to test_path @question.test
  end

  private
  def correct_question
    @question = Question.find_by id: params[:id]
  end
end
