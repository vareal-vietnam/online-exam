class ResultsController < ApplicationController
  before_action :check_is_logged_in
  before_action :check_is_admin_permission
  before_action :get_test

  def index
    @results = @test.results.includes :user
    @results = @results.paginate(page: params[:page])
  end

  private

  def get_test
    @test = Test.find_by id: params[:test_id]
    return if @test

    flash[:danger] = t 'error_404'
    redirect_to root_path
  end
end
