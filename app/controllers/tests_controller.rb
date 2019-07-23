class TestsController < ApplicationController
  before_action :check_is_logged_in
  def index
    if current_user.is_admin?
      @tests = Test.all
      render "index"
    else
      render "index_user"
    end
  end
end
