require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#account_activation' do
    let(:user) { create :user, :not_active }
    let(:mail) { UserMailer.account_activation(user).deliver_now }

    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq([ENV['email_address']]) }
    it { expect(mail.body.encoded).to match(user.name) }
  end

  describe '#password_reset' do
    let(:user) { create :user }
    before { user.create_reset_digest }
    let(:mail) { UserMailer.password_reset(user).deliver_now }

    it { expect(mail.to).to eq([user.email]) }
    it { expect(mail.from).to eq([ENV['email_address']]) }
  end
end
