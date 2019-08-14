require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#new' do
    context do
      before { get :new }

      it { is_expected.to render_template 'new' }
    end
  end

  describe '#create' do
    context 'Can login' do
      let(:user) { create :user }
      before do
        post :create,
             params: { session: { email: user.email, password: '123456' } }
      end

      it { is_expected.to redirect_to root_path }
    end

    context 'Login with account not activated' do
      let(:user) { create :user, :not_active }
      before do
        post :create,
             params: { session: { email: user.email, password: '123456' } }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end

    context 'Can not login, email not exist' do
      before do
        post :create,
             params: { session: { email: 'abc@xyz', password: '123456' } }
      end

      it { is_expected.to set_flash }
      it { is_expected.to render_template 'new' }
    end

    context 'Can not login, password error' do
      let(:user) { create :user }
      before do
        post :create,
             params: { session: { email: user.email, password: '000000' } }
      end

      it { is_expected.to set_flash }
      it { is_expected.to render_template 'new' }
    end
  end

  describe '#destroy' do
    let(:user) { create :user }
    before do
      session[:user_id] = user.id
      get :destroy
    end

    it { expect(session[:user_id]).to be_nil }
    it { is_expected.to redirect_to root_path }
  end
end
