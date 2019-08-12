require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_logged_in) { @user = create :user }
  let(:admin_logged_in) { @user = create :user, :admin }
  let(:user_saved) { create :user }
  let(:user_new) { User.new }


  describe 'Check get#index' do
    context 'Check with anonymous' do
      before { get :index }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end

    context 'Check with normal user' do
      before { session[:user_id] = user_logged_in.id }

    end

    context 'Check with admin' do
      before { session[:user_id] = admin_logged_in.id }
      before { get :index }

      it { is_expected.to render_template 'index' }
    end
  end

  describe 'Check get#show' do
    context 'Check with anonymous' do
      before { get :show, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end

    context 'Check with normal user' do
      before { session[:user_id] = user_logged_in.id }
      before { get :show, params: { id: user_saved.id } }

      it { is_expected.to render_template 'show' }
    end

    context 'Check with admin' do
      before { session[:user_id] = admin_logged_in.id }
      before { get :show, params: { id: user_saved.id } }

      it { is_expected.to render_template 'show' }
    end
  end

  describe 'Check get#new' do
    context 'Check with anonymous' do
      before { get :new }

      it { is_expected.to render_template :new }
      it do
        is_expected.to render_template(partial: '_form',
                                       locals: { user: user_new })
      end
    end

    context 'Check with normal user' do
      before { session[:user_id] = user_logged_in.id }
    end

    context 'Check with admin' do
      before { session[:user_id] = admin_logged_in.id }
      before { get :index }

      it { is_expected.to render_template 'index' }
    end
  end

  describe 'Check post#create' do
    context 'Check with anonymous' do
    end

    context 'Check with normal user' do
    end

    context 'Check with admin' do
    end
  end

  describe 'Check get#edit' do
    context 'Check with anonymous' do
      before { get :edit, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
      it { is_expected.to respond_with 302 }
    end

    context 'Check with normal user' do
      before { session[:user_id] = user_logged_in.id }
      before { get :edit, params: { id: user_saved.id } }

      # it { is_expected.to set_flash }
      # it { is_expected.to redirect_to '/' }
      # it { is_expected.to respond_with 302 }
    end

    context 'Check with admin' do
      before { session[:user_id] = admin_logged_in.id }
      before { get :edit, params: { id: user_saved.id } }

      it { is_expected.to render_template 'edit' }
      it { is_expected.to render_template partial: '_form', locals: { user: user_saved } }
    end
  end

  describe 'Check post#create' do
    context 'Check with anonymous' do
      before { delete :destroy, params: { id: user_saved.id } }
    end

    context 'Check with normal user' do
      before { session[:user_id] = user_logged_in.id }
      before { delete :destroy, params: { id: user_saved.id } }

      # it { is_expected.to set_flash }
      # it { is_expected.to redirect_to '/' }
      # it { is_expected.to respond_with 302 }
    end

    context 'Check with admin' do
      before { session[:user_id] = admin_logged_in.id }
      before { delete :destroy, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to users_path }
    end
  end
end
