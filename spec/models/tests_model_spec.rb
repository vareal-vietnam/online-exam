require 'rails_helper'

RSpec.describe Test, type: :model do
  let(:test) { build :test }
  let(:test_saved) { create :test }

  it { is_expected.to have_many(:results).dependent(:destroy) }
  it { is_expected.to have_many(:questions).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it do
    is_expected.to validate_length_of(:name)
      .is_at_least(3).is_at_most(255)
  end

  it '#nested questions' do
    is_expected.to accept_nested_attributes_for(:questions)
      .allow_destroy(true)
  end

  it { is_expected.to validate_presence_of(:kind) }
  it do
    is_expected.to define_enum_for(:kind)
      .with_values %i[git rails]
  end
  it { is_expected.to validate_presence_of(:time) }
  it { is_expected.to validate_numericality_of(:time).only_integer }

  describe '#before_save' do
    let(:test) { build :test, name: 'Test   name' }

    before { test.save }

    it do
      expect(test.name).to eq('Test name')
    end
  end
end
