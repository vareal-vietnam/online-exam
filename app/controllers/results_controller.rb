class ResultsController < ApplicationController
  before_action :get_test

  def index
    @results = @test.results.includes :user
    @results = @results.paginate(page: params[:page], per_page: 1)
  end

  private

  def get_test
    @test = Test.find_by id: params[:test_id]
    return @test if @test

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end
end
