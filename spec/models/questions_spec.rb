require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to belong_to(:test) }
  it { is_expected.to have_many(:answers).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:test) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(255) }

  describe '#nested_attributes' do
    it do
      is_expected.to accept_nested_attributes_for(:answers)
        .allow_destroy(true)
    end
  end

  describe '#trim_space_content' do
    let(:question) { build :question, content: 'Question     1' }
    before { question.save }

    it { expect(question.content).to eq('Question 1') }
  end
end
