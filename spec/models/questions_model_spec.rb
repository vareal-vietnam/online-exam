require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build :question }

  it { is_expected.to belong_to(:test) }
  it { is_expected.to have_many(:answers).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:test) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(255) }

  it '#Before save' do
    question.content = 'Question     1'
    question.run_callbacks :save
    expect(question.content).to eq('Question 1')
  end

  it 'Check nested attribute' do
    is_expected.to accept_nested_attributes_for(:answers)
      .allow_destroy(true)
  end
end
