require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation user' do
    it 'ensures email, password, presence' do
      user = User.new(name: 'Tran Hai').save
      expect(user).to eq(false)
    end
    it 'email is not valide' do
      user = User.new(email: 'foobar').save
      expect(user).to eq(false)
    end
    it 'should save successfully' do
      user = User.new(name: 'Tran Hai',
                      email: 'tranhai174595218@gmail.com',
                      password: '123456').save
      expect(user).to eq(true)
    end
  end

  describe 'length validations' do
    it 'password is too short if password is less than 6 chracters' do
      short_password = User.create(password: '12345')
      expect(short_password).not_to be_valid
    end
    it 'should not allow a name shorter than 3 characters' do
      user = User.create(name: 'aaa')
      expect(user).not_to be_valid
    end
    it 'should not allow a name longer than 50 characters ' do
      user = User.new
      user.name = 'h' * 51
      expect(user).not_to be_valid
    end
    it 'should not allow an email too longer than 255 characters' do
      user = User.new
      user.email = 'a' * 256
      expect(user).not_to be_valid
    end
  end
end
