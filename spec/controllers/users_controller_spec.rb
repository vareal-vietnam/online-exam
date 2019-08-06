require "rails_helper"

RSpec.configure do |config|
  config.filter_rails_from_backtrace!
end

RSpec.describe UsersController, type: :controller do
  describe "GET index" do
    it "has a 302 status code" do
      get :index
      expect(response.status).to eq(302)
    end
  end

  describe "responds to" do
    it "responds to html by default" do
      post :create, { :widget => { :name => "Any Name"}}
      expect(response.content_type).to eq "text/html"
    end
  end
end
