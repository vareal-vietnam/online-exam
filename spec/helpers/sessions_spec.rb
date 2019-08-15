require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create :user }

  describe '#log_in' do
    before { helper.log_in user }

    it { expect(session[:user_id]).to eq(user.id) }
  end

  describe '#current_user' do
    subject { helper.current_user }

    context 'Session is exist' do
      before { session[:user_id] = user.id }

      it { is_expected.to eq(user) }
    end

    context 'Session is not exist' do
      it { is_expected.to be_nil }
    end
  end

  describe '#log_out' do
    before do
      session[:user_id] = user.id
      helper.log_out
    end
    subject { session[:user_id] }

    it { is_expected.to be_nil }
  end

  describe '#logged_in' do
    subject { helper.logged_in? }

    context 'User logged in' do
      before { session[:user_id] = user.id }

      it { is_expected.to eq(true) }
    end

    context 'User not login' do
      it { is_expected.to eq(false) }
    end
  end
end
