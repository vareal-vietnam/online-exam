require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:user_saved) { create :user }

  describe '#index' do
    context 'Logged in with admin' do
      before do
        session[:user_id] = admin.id
        get :index
      end

      it { is_expected.to render_template 'index' }
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :index
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :index }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#show' do
    context 'Logged in with admin' do
      context 'Can find user' do
        before do
          session[:user_id] = admin.id
          get :show, params: { id: user_saved.id }
        end

        it { is_expected.to render_template 'show' }
      end

      context 'Can not find user' do
        before do
          session[:user_id] = admin.id
          get :show, params: { id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :show, params: { id: user_saved.id }
      end

      it { is_expected.to render_template 'show' }
      it do
        is_expected.to render_template(partial: '_form',
                                       locals: { user: user })
      end
    end

    context 'Not login' do
      before { get :show, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
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

      it { is_expected.to render_template 'new' }
    end
  end

  describe '#create' do
    context 'Logged in with admin' do
      let(:user_params) { attributes_for :user }
      before do
        session[:user_id] = admin.id
        post :create, params: { user: user_params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to users_path }
    end

    context 'Logged with user' do
      let(:user_params) { attributes_for :user, :not_active }
      before do
        session[:user_id] = user.id
        post :create, params: { user: user_params }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      let(:user_params) { attributes_for :user, :not_active }
      before { post :create, params: { user: user_params } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#edit' do
    context 'Logged in with admin' do
      context 'Can find user' do
        before do
          session[:user_id] = admin.id
          get :edit, params: { id: user_saved.id }
        end

        it { is_expected.to render_template 'edit' }
      end

      context 'Can not find user' do
        before do
          session[:user_id] = admin.id
          get :edit, params: { id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :edit, params: { id: user_saved.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { get :edit, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#update' do
    context 'Logged in with admin' do
      context 'Can find user' do
        let(:user_params) { attributes_for :user }
        before do
          session[:user_id] = admin.id
          post :update, params: { id: user_saved.id, user: user_params }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to users_path }
      end

      context 'Can not find user' do
        let(:user_params) { attributes_for :user }
        before do
          session[:user_id] = admin.id
          post :update, params: { id: -1, user: user_params }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      context 'Edit yourself' do
        let(:user_params) { attributes_for :user }
        before do
          session[:user_id] = user.id
          post :update, params: { id: user.id, user: user_params }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to user_path(user) }
      end

      context 'Edit other user' do
        let(:user_params) { attributes_for :user }
        before do
          session[:user_id] = user.id
          post :update, params: { id: user_saved.id, user: user_params }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to user_path(user) }
      end
    end

    context 'Not login' do
      let(:user_params) { attributes_for :user, :not_active }
      before { post :update, params: { id: user_saved.id, user: user_params } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#destroy' do
    context 'Logged in with admin' do
      context 'Can find user' do
        before do
          session[:user_id] = admin.id
          delete :destroy, params: { id: user_saved.id }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to users_path }
      end

      context 'Can not find user' do
        before do
          session[:user_id] = admin.id
          get :show, params: { id: -1 }
        end

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to root_path }
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        delete :destroy, params: { id: user_saved.id }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Not login' do
      before { delete :destroy, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#edit_profile' do
    context 'Logged in with admin' do
      before do
        session[:user_id] = admin.id
        get :edit_profile
      end

      it { is_expected.to render_template 'edit' }
      it do
        is_expected.to render_template(partial: '_form',
                                       locals: { user: admin })
      end
    end

    context 'Logged with user' do
      before do
        session[:user_id] = user.id
        get :edit_profile
      end

      it { is_expected.to render_template 'edit' }
      it do
        is_expected.to render_template(partial: '_form',
                                       locals: { user: user })
      end
    end

    context 'Not login' do
      before { get :edit_profile }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end
end
