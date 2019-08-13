require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  describe 'password' do
    describe 'when password is too short' do
      it 'is not valid' do
        user = build(:user, password: '123')
        user.valid?
        expect(user.errors[:password]).to include('is too short /
          (minimum is 6 characters)')
      end
    end

    describe 'when password is valid' do
      it 'is valid' do
        user = build(:user, password: '123456')
        expect(user).to be_valid
      end
    end

    describe 'when password is nil' do
      it 'is not valid' do
        user = build(:user, password: '')
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
    end
  end

  describe 'email' do
    describe 'when email is not valid' do
      it 'is not valid' do
        user = build(:user, email: 'tranhaigmail.com')
        user.valid?
        expect(user.errors[:email]).to include('is invalid')
      end
    end

    describe 'when email is valid' do
      it 'is valid' do
        user = build(:user, email: 'tranhai@gmail.com')
        user.valid?
        expect(user).to be_valid
      end
    end

    describe 'when email is too long' do
      it 'is not valid' do
        fake_email = 'a' * 256
        user = build(:user, email: fake_email)
        user.valid?
        expect(user.errors[:email]).to include('is too long /
          (maximum is 255 characters)')
      end
    end
  end

  describe 'name' do
    describe 'when name is too short' do
      it 'is not valid' do
        user = build(:user, name: 'Hai')
        user.valid?
        expect(user.errors[:name]).to include
      end
    end

    describe 'when name is too long' do
      it 'is not valid' do
        fake_name = 'a' * 51
        user = build(:user, name: fake_name)
        user.valid?
        expect(user.errors[:name]).to include('is too long /
          (maximum is 50 characters)')
      end
    end
  end

  describe 'Check associate between user table and results table ' do
    it 'user has many results' do
      is_expected.to have_many(:results)
    end
  end

  describe 'Check callback' do
    it 'Check callback before save' do
      user = build(:user, email: 'HAITRAN@gmail.com')
      user.run_callbacks :save
      expect(user.email).to eq('haitran@gmail.com')
    end

    it 'Check callback before create' do
      user = create(:user)
      user.run_callbacks :create
      expect(user.activation_token).not_to be_nil
      expect(user.activation_digest).not_to be_nil
    end
  end

  describe 'check password reset condition' do
    it 'password reset is expired' do
      user = create(:user, reset_send_at: 3.hours.ago)
      expect(user.password_reset_expired?).to eq(true)
    end

    it 'password reset is not expired' do
      user = create(:user, reset_send_at: 0.5.hours.ago)
      expect(user.password_reset_expired?).to eq(false)
    end
  end
end
