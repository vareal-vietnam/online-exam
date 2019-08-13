require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build :question }

  describe 'Check callback' do
    it '#Before save' do
      question.content = 'Question     1'
      question.run_callbacks :save
      expect(question.content).to eq('Question 1')
    end
  end

  describe 'Check associate' do
    context '#belong_to test' do
      it { is_expected.to belong_to(:test) }
    end

    context '#has_many' do
      it { is_expected.to have_many(:answers).dependent(:destroy) }
    end
  end

  describe 'Check nested attribute' do
    it do
      is_expected.to accept_nested_attributes_for(:answers)
        .allow_destroy(true)
    end
  end

  describe 'Check validate' do
    context '#Validate content' do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_length_of(:content).is_at_most(255) }
    end

    context '#Validate test' do
      it { is_expected.to validate_presence_of(:test) }
    end
  end
end
