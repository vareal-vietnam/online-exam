require 'rails_helper'

RSpec.describe Test, type: :model do
  it { is_expected.to have_many(:results).dependent(:destroy) }
  it { is_expected.to have_many(:questions).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it do
    is_expected.to validate_length_of(:name)
      .is_at_least(3).is_at_most(255)
  end

  it { is_expected.to validate_presence_of(:time) }
  it { is_expected.to validate_numericality_of(:time).only_integer }
  it { is_expected.to validate_presence_of(:kind) }
  it do
    is_expected.to define_enum_for(:kind)
      .with_values %i[git rails]
  end

  describe '#nested questions' do
    it 'Can accept nested question attributes' do
      is_expected.to accept_nested_attributes_for(:questions)
        .allow_destroy(true)
    end
  end

  describe '#trim_space_content' do
    let(:test) { build :test, name: 'Test   name' }
    before { test.save }

    it { expect(test.name).to eq('Test name') }
  end
end
