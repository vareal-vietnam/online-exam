require 'rails_helper'

RSpec.describe User, type: :model do
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

  describe '#downcase_email' do
    let(:user) { build :user, email: 'ABC@gmail.com' }
    before { user.save }

    it { expect(user.email).to eq('abc@gmail.com') }
  end

  describe '#trim double space' do
    let(:user) { build :user, name: 'Your     name' }
    before { user.save }

    it { expect(user.name).to eq('Your name') }
  end

  describe '#create_activation_digest' do
    let(:user) { build :user }
    before { user.save }

    it 'Can create activation digest' do
      expect(user.activation_token).not_to be_nil
      expect(user.activation_digest).not_to be_nil
    end
  end

  describe '#create_reset_digest' do
    let(:user) { create :user }
    before { user.create_reset_digest }

    it 'Can create reset_digest correctly' do
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

  describe '#digest' do
    it { expect(User.digest('abc')).to be_a_kind_of(String) }
  end

  describe '#new_token' do
    it { expect(User.new_token).to be_a_kind_of(String) }
  end
end
