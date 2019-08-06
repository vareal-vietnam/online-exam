require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns a 209 custom status code" do
      get :index
      expect(response).to have_http_status(:found)
    end
  end

  describe "Get #new" do
    it "Test" do
      get :new
      expect(response.status).to eq(200)
    end
  end
end
