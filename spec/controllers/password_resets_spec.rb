require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe '#new' do
    context do
      before { get :new }

      it { is_expected.to render_template 'new' }
    end
  end

  describe '#create' do
    let(:user) { create :user }

    context 'Can find user' do
      before { get :create, params: { password_reset: { email: user.email } } }

      it { expect(assigns(:user).reset_digest).not_to be_nil }
      it { expect(assigns(:user).reset_send_at).not_to be_nil }
      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end

    context 'Can not find user' do
      before { get :create, params: { password_reset: { email: 'abc@xyz' } } }

      it { is_expected.to set_flash }
      it { is_expected.to render_template 'new' }
    end
  end

  describe '#edit' do
    context 'Can find user' do
      context 'Url is not expired' do
        context 'Authenticated' do
          let(:token) { User.new_token }
          let(:user) do
            create :user,
                   reset_send_at: 0.5.hours.ago,
                   reset_digest: User.digest(token)
          end
          before { get :edit, params: { id: token, email: user.email } }

          it { is_expected.to render_template 'edit' }
        end

        context 'Not authenticated' do
          let(:user) do
            create :user, reset_send_at: 0.5.hours.ago, reset_digest: nil
          end
          before { get :edit, params: { id: user.id, email: user.email } }

          it { is_expected.to set_flash }
          it { is_expected.to render_template 'new' }
        end
      end

      context 'Url is expired' do
        let(:user) { create :user, reset_send_at: 2.hours.ago }
        before { get :edit, params: { id: user.id, email: user.email } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to new_password_reset_path }
      end
    end

    context 'Can not find user' do
      before { get :edit, params: { id: -1, email: 'abc@xyz' } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end
  end

  describe '#update' do
    context 'Can find user' do
      context 'Url is not expired' do
        context 'Can update' do
          let(:user) { create :user, reset_send_at: 0.5.hours.ago }
          before do
            put :update,
                params: { id: user.id,
                          email: user.email,
                          password_reset: { password: '123456',
                                            password_confirmation: '123456' } }
          end

          it { expect(user.reset_digest).to be_nil }
          it { is_expected.to set_flash }
          it { is_expected.to redirect_to login_path }
        end

        context 'Can not update' do
          let(:user) { create :user, reset_send_at: 0.5.hours.ago }
          before do
            put :update,
                params: { id: user.id,
                          email: user.email,
                          password_reset: { password: '123456',
                                            password_confirmation: '1234567' } }
          end

          it { is_expected.to set_flash }
          it { is_expected.to render_template 'edit' }
        end
      end

      context 'Url is expired' do
        let(:user) { create :user, reset_send_at: 2.hours.ago }
        before { put :update, params: { id: user.id, email: user.email } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to new_password_reset_path }
      end
    end

    context 'Can not find user' do
      let(:user) { create :user, reset_send_at: 0.5.hours.ago }
      before do
        put :update,
            params: { id: user.id, email: 'abc@xyz' }
      end

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to root_path }
    end
  end
end
