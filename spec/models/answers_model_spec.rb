require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build :answer }

  describe 'Check callback' do
    it '#befor save' do
      answer.content = 'Answer    content'
      answer.run_callbacks :save
      expect(answer.content).to eq('Answer content')
    end
  end

  describe 'Check association' do
    context '#belong_to question' do
      it { is_expected.to belong_to(:question) }
    end

    context '#has_many result_answers' do
      it { is_expected.to have_many(:result_answers).dependent(:destroy) }
    end
  end
end
