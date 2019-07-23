class TestsController < ApplicationController
  before_action :check_is_logged_in

  def index
    @tests = Test.all
    if current_user.is_admin?
      render "tests/admin/index"
    end
  end
end
