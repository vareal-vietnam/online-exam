require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Test with anonymous' do
    let(:user_saved) do
      User.create id: 1,
                  name: 'name',
                  email: 'email@gmail.com',
                  password: 'password',
                  password_confirmation: 'password'
    end

    context 'Test Get index' do
      before { get :index }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to('/login') }
    end

    context 'Test Get show' do
      before { get :show, params: { id: user_saved.id } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to('/login') }
    end

    context 'Test Get new' do
      let(:user) { User.new }

      before { get :new }

      it { is_expected.to render_template :new }
      it do
        is_expected.to render_template(partial: '_form',
                                       locals: { user: user })
      end
    end

    context 'Test Post create' do
      it do
        user_params = {
          user: {
            name: 'name',
            email: 'email@gmail.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
        is_expected.to permit(:name, :email, :password, :password_confirmation)
          .for(:create, params: user_params).on(:user)
        is_expected.to render_template(:account_activation)
        is_expected.to set_flash
        is_expected.to redirect_to('/login')
      end
    end

    context 'Test Get edit' do
      before { get :edit, params: { id: user_saved.id } }

      it { is_expected.to redirect_to('/login') }
    end

    context 'Test Delete destroy' do
      before { delete :destroy, params: { id: user_saved.id } }

      it { is_expected.to redirect_to('/login') }
    end
  end

  describe 'Test with normal user' do
    let(:user_log) do
      @user = User.create id: 1,
                          name: 'username',
                          email: 'email@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          activated: true
    end

    before { session[:user_id] = user_log.id }

    context 'Test get show' do
      it do
        get :edit_profile
        is_expected.to render_template 'edit'
      end
    end
  end
end
