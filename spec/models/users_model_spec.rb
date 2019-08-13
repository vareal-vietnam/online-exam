require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_create) { build :user }
  let(:user) { create :user }

  it { is_expected.to validate_presence_of(:name) }
  it do
    is_expected.to validate_length_of(:name)
      .is_at_least(3).is_at_most(50)
  end
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to allow_value('abc@gmail.com').for(:email) }
  it { is_expected.to validate_presence_of(:password).allow_nil }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  it { is_expected.to have_many(:results) }

  it { is_expected.to have_secure_password }

  describe '#before_save' do
    let(:user) { build :user, email: 'ABC@gmail.com', name: 'Your   name' }

    before { user.save }

    it '#downcase_email' do
      expect(user.email).to eq('abc@gmail.com')
    end
    it '#trim double space' do
      expect(user.name).to eq('Your name')
    end
  end

  describe '#before create' do
    before { user_create.save }

    it do
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
    context '#digest' do
      subject { User.digest('abc') }
      it { expect(subject).to be_a_kind_of(String) }
    end

    context '#new_token' do
      it { expect(User.new_token).to be_a_kind_of(String) }
    end
  end
end
