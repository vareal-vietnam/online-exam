require 'rails_helper'

RSpec.describe Test, type: :model do
  describe 'Check validate' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_presence_of(:time) }
    it { is_expected.to validate_numericality_of(:time).only_integer }
  end

  describe 'Check has many' do
    it { is_expected.to have_many(:results).dependent(:destroy) }
    it { is_expected.to have_many(:questions).dependent(:destroy) }
  end
end
