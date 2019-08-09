require 'rails_helper'

RSpec.describe Test, type: :model do
  describe 'Check validate' do
    it { is_expected.to validate_presence_of(:name) }
    it {is_expected.to validate_presence_of(:kind) }
    it {is_expected.to validate_presence_of(:time) }
  end
end
