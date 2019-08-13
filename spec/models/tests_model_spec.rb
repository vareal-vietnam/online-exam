require 'rails_helper'

RSpec.describe Test, type: :model do
  let(:test) { build :test }
  let(:test_saved) { create :test }

  describe 'Check callback' do
    it '#before save' do
      test.name = 'test   name'
      test.run_callbacks :save
      expect(test.name).to eq('test name')
    end
  end

  describe 'Check has_many' do
    context '#has_many results' do
      it { is_expected.to have_many(:results).dependent(:destroy) }
    end

    context '#has_many questions' do
      it { is_expected.to have_many(:questions).dependent(:destroy) }
    end
  end

  describe 'Check nested attribute' do
    it '#nested questions' do
      is_expected.to accept_nested_attributes_for(:questions)
        .allow_destroy(true)
    end
  end

  describe 'Check validate' do
    context '#validate name' do
      it { is_expected.to validate_presence_of(:name) }
      it do
        is_expected.to validate_length_of(:name)
          .is_at_least(3).is_at_most(255)
      end
    end

    context '#validate kind' do
      it { is_expected.to validate_presence_of(:kind) }
      it do
        is_expected.to define_enum_for(:kind)
          .with_values %i[git rails]
      end
    end

    context '#validate time' do
      it { is_expected.to validate_presence_of(:time) }
      it { is_expected.to validate_numericality_of(:time).only_integer }
    end
  end
end
