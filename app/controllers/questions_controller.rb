class QuestionsController < ApplicationController
  before_action :get_question
  def show
    @questions = @test.questions
  end

  private
  def get_question
    @test = Test.find(1)
  end
end
