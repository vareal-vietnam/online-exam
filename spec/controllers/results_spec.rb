require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:test) { create :test }
  let(:result) { create :result, test: test }

  describe '#show' do
    context 'Logged in with user, can find result' do
      before do
        session[:user_id] = user.id
        get :show, params: { test_id: test.id, id: result.id }
      end

      it { is_expected.to render_template 'show' }
    end

    context 'Logged in with user, can not find result' do
      before do
        session[:user_id] = user.id
        get :show, params: { test_id: test.id, id: -1 }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :show, params: { test_id: test.id, id: result.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#create' do
    let(:params) { attributes_for :result }

    context 'Logged in with user, can find test' do
      before do
        session[:user_id] = user.id
        put :create, params: { test_id: test.id, result: params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to test_result_path(test, assigns(:result)) }
    end

    context 'Logged in with user, can not find test' do
      before do
        session[:user_id] = user.id
        put :create, params: { test_id: -1, result: params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { put :create, params: { test_id: test.id, result: params } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#index' do
    context 'Logged in with admin, can find test' do
      before do
        session[:user_id] = admin.id
        get :index, params: { test_id: test.id }
      end

      it { is_expected.to render_template 'index' }
    end

    context 'Logged in with admin, can not find test' do
      before do
        session[:user_id] = admin.id
        get :index, params: { test_id: -1 }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Logged in with user' do
      before do
        session[:user_id] = user.id
        get :index, params: { test_id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before do
        get :index, params: { test_id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end
end
