require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Check valid' do
    context 'Check valid name' do
      it { is_expected.to validate_presence_of(:name) }
      it do
        is_expected.to validate_length_of(:name)
          .is_at_least(3).is_at_most(50)
      end
    end

    context 'Check valid email' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to allow_value('abc@gmail.com').for(:email) }
    end

    context 'Check valid password' do
      it { is_expected.to validate_presence_of(:password).allow_nil }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end
  end

  describe 'Check has many' do
    it { is_expected.to have_many(:results) }
  end

  describe 'Check secure password' do
    it { is_expected.to have_secure_password }
  end

  describe 'Check callback' do
    let(:user) do
      build :user, :not_admin
    end

    it 'Check callback before save' do
      user.email = 'ABC@gmail.com'
      user.run_callbacks :save
      expect(user.email).to eq('abc@gmail.com')
    end

    it 'Check callback befor create' do
      user.run_callbacks :create
      expect(user.activation_token).not_to be_nil
      expect(user.activation_digest).not_to be_nil
    end
  end
end
