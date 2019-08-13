require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_create) { build :user }
  let(:user) { create :user }

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
    it 'Check callback before save' do
      user_create.email = 'ABC@gmail.com'
      user_create.run_callbacks :save
      expect(user_create.email).to eq('abc@gmail.com')
    end

    it 'Check callback before create' do
      user_create.run_callbacks :create
      expect(user_create.activation_token).not_to be_nil
      expect(user_create.activation_digest).not_to be_nil
    end
  end

  describe '#create_reset_digest' do
    before { user.create_reset_digest }

    it 'can create reset_digest correctly' do
      expect(user.reset_token).not_to be_nil
      expect(user.reset_digest).not_to be_nil
      expect(user.reset_send_at).not_to be_nil
    end
  end

  describe '#password_reset_expired?' do
    context 'password_reset is expired' do
      let(:user) { create :user, reset_send_at: 2.hours.ago }

      it { expect(user.password_reset_expired?).to eq(true) }
    end

    context 'password_reset is not expired' do
      let(:user) { create :user, reset_send_at: 0.5.hours.ago }

      it { expect(user.password_reset_expired?).to eq(false) }
    end
  end

  describe 'Check class method' do
    context 'Check digest' do
      subject { User.digest('abc') }
      it { expect(subject).to be_a_kind_of(String) }
    end
  end
end
