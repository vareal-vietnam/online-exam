require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { create :user }

  describe '#log_in' do
    before { helper.log_in user }

    it { expect(session[:user_id]).to eq(user.id) }
  end

  describe '#current_user' do
    context 'Exist session' do
      before { session[:user_id] = user.id }
      subject { helper.current_user }

      it { is_expected.to eq(user) }
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
    context 'User logged in' do
      before { session[:user_id] = user.id }
      subject { helper.logged_in? }

      it { is_expected.to eq(true) }
    end

    context 'User not login' do
      subject { helper.logged_in? }

      it { is_expected.to eq(false) }
    end
  end
end
