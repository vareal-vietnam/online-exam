class QuestionsController < ApplicationController
  before_action :check_is_logged_in, :check_is_admin_permission
  before_action :get_question, only: %i[edit update destroy]

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t '.sucess_update'
      redirect_to test_path @question.test
    else
      flash[:danger] = t '.updates_failed'
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = t '.question_deleted'
    redirect_to test_path @question.test
  end

  private

  def get_question
    @question = Question.find_by id: params[:id]
  end

  def question_params
    params.require(:question).permit(:content,
                                     answers_attributes: %i[id content])
  end
end
