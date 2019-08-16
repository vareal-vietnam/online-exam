require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
  describe '#edit' do
    context 'Can find user' do
      context 'User activeted' do
        let(:user) { create :user }
        before { get :edit, params: { id: 1, email: user.email } }

        it { is_expected.to set_flash }
        it { is_expected.to redirect_to login_path }
      end

      context 'User not active' do
        context 'User not authenticated' do
          let(:user) do
            create :user, :not_active
          end
          before { get :edit, params: { id: 1, email: user.email } }

          it { is_expected.to set_flash }
          it { is_expected.to redirect_to login_path }
        end

        context 'User authenticated' do
          let(:token) { User.new_token }
          let(:user) { create :user, :not_active }
          before do
            get :edit, params: { id: user.activation_token, email: user.email }
          end

          it { expect(user.reload.activated).to eq(true) }
          it { expect(user.reload.activated_at).not_to be_nil }
          it { is_expected.to set_flash }
          it { is_expected.to redirect_to root_path }
        end
      end
    end

    context 'Can not find user' do
      before { get :edit, params: { id: 1, email: 'abc@gmail.com' } }

      it { is_expected.to set_flash }
      it { is_expected.to redirect_to login_path }
    end
  end
end
