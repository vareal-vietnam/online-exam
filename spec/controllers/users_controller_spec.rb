require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Check with anonymous' do
    let(:user_saved) { create :user, :not_admin }
    let(:user) { User.new }

    context 'Check Get index' do
      before { get :index }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end

    context 'Check Get show' do
      before { get :show, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to '/login' }
    end

    context 'Check Get new' do
      before { get :new }

      it { is_expected.to render_template :new }
      it do
        is_expected.to render_template(partial: '_form',
                                       locals: { user: user })
      end
    end

    context 'Check Post create' do
      it do
        user_params = { user: attributes_for(:user) }
        is_expected.to permit(:name, :email, :password, :password_confirmation)
          .for(:create, params: user_params).on(:user)
        is_expected.to render_template :account_activation
        is_expected.to set_flash
        is_expected.to redirect_to '/login'
      end
    end

    context 'Check Get edit' do
      before { get :edit, params: { id: user_saved.id } }

      it { is_expected.to redirect_to '/login' }
    end

    context 'Check Delete destroy' do
      before { delete :destroy, params: { id: user_saved.id } }

      it { is_expected.to redirect_to '/login' }
    end
  end

  describe 'Check with normal user' do
    let(:user_logged_in) { @user = create :user, :not_admin }

    before { session[:user_id] = user_logged_in.id }

    context 'Check get show' do
      it do
        get :edit_profile
        is_expected.to render_template 'edit'
      end
    end
  end

  describe 'Check with admin' do
    let(:admin_logged_in) { @user = create :user, :admin }
    before { session[:user_id] = admin_logged_in.id }

    context 'Check get index' do
      before { get :index }
      it { is_expected.to render_template 'index' }
    end

    context 'Check get new' do
      before { get :new }
      it { is_expected.to render_template 'new' }
    end
  end
end
