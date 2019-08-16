require "rails_helper"
RSpec.describe User, type: :model do
  describe 'Check valid' do
    context 'Check valid name' do
      it { is_expected.to validate_presence_of(:name) }
      it do
        is_expected.to validate_length_of(:name)
          .is_at_least(3).is_at_most(50)
      end
    end

    context 'check valid email' do
      it { is_expected.to validate_presence_of(:email)}
      it { is_expected.to validate_length_of(:email).is_at_most(255)}
      it {is_expected.to allow_value('tranhai@gmail.com').for(:email)}
    end
  end

  describe 'check has many' do
    it{is_expected.to have_many(:results)}
  end

  describe 'check secure password' do
    it{is_expected.to have_secure_password}
  end

  describe 'check callback' do
    it 'check call back before save' do
      user_create.email = 'ABC@gmail.com'
      user_create.run_callbacks :save

  end
end
