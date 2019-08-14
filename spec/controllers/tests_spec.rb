require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:test) { create :test }

  describe '#index' do
    context 'Logged in with admin' do
      before do
        session[:user_id] = admin.id
        get :index
      end

      it { is_expected.to render_template 'tests/admin/index' }
    end

    context 'Logged with user or not login' do
      before { get :index }

      it { is_expected.to render_template 'index' }
    end
  end

  describe '#show' do
    context 'Logged in with admin, can find test' do
      before do
        session[:user_id] = admin.id
        get :show, params: { id: test.id }
      end

      it { is_expected.to render_template 'tests/admin/show' }
    end

    context 'Logged in with admin, can not find test' do
      before do
        session[:user_id] = admin.id
        get :show, params: { id: -1 }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :show, params: { id: test.id }
      end

      it { is_expected.to render_template 'show' }
    end

    context 'Not login' do
      before { get :show, params: { id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#new' do
    context 'Logged in with admin' do
      before do
        session[:user_id] = admin.id
        get :new
      end

      it { is_expected.to render_template 'new' }
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :new
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :new }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#create' do
    let(:test_params) { attributes_for :test }
    context 'Logged in with admin, can save' do
      before do
        session[:user_id] = admin.id
        put :create, params: { test: test_params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Logged in with admin, can not save' do
      let(:test_params) { attributes_for :test, name: '' }
      before do
        session[:user_id] = admin.id
        put :create, params: { test: test_params }
      end

      it { is_expected.to render_template 'new' }
      it do
        is_expected.to render_template(partial: '_form',
                                       locals: { test: assigns(:test) })
      end
      it do
        is_expected.to render_template(partial: 'shared/error_messages',
                                       locals: { object: assigns(:test) })
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        put :create, params: { test: test_params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { put :create, params: { test: test_params } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#edit' do
    context 'Logged in with admin, can find test' do
      before do
        session[:user_id] = admin.id
        get :edit, params: { id: test.id }
      end

      it { is_expected.to render_template 'edit' }
      it do
        is_expected.to render_template(partial: '_form', locals: { test: test })
      end
    end

    context 'Logged in with admin, can not find test' do
      before do
        session[:user_id] = admin.id
        get :edit, params: { id: -1 }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :edit, params: { id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :edit, params: { id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#update' do
    let(:test_params) { attributes_for :test }

    context 'Logged in with admin, can save' do
      before do
        session[:user_id] = admin.id
        put :update, params: { id: test.id, test: test_params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Logged in with admin, can not save' do
      let(:test_params) { attributes_for :test, name: '' }
      before do
        session[:user_id] = admin.id
        put :update, params: { id: test.id, test: test_params }
      end

      it { is_expected.to render_template 'edit' }
      it do
        is_expected.to render_template(partial: '_form', locals: { test: test })
      end
      it do
        is_expected.to render_template(partial: 'shared/error_messages',
                                       locals: { object: test })
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        put :update, params: { id: test.id, test: test_params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { put :update, params: { id: test.id, test: test_params } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end

  describe '#destroy' do
    context 'Logged in with admin, can find test' do
      before do
        session[:user_id] = admin.id
        delete :destroy, params: { id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Logged in with admin, can not find test' do
      before do
        session[:user_id] = admin.id
        delete :destroy, params: { id: -1 }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        delete :destroy, params: { id: test.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { delete :destroy, params: { id: test.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end
  end
end
