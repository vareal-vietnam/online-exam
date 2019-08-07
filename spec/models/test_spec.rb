require "rails_helper"

RSpec.describe Test, type: :model do
  describe 'validation test' do
    it 'ensure kind presence' do
      test = Test.new(name: "Git Test", time: "600").save
      expect(test).to eq(false)
    end
    it 'ensure time presence' do
      test = Test.new(name: "Git Test", kind: :git).save
      expect(test).to eq(false)
    end
    it 'only accept integer for field time' do
      test = Test.new(name: "Git Test Pro", kind: :git, time: "abc").save
      expect(test).to eq(false)
    end
    it 'the right kind test' do
      test = Test.new(name: "Git Test Pro", kind: :git, time: "600").save
      expect(test).to eq(true)
    end
  end
end
