require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build :answer }

  it { is_expected.to belong_to(:question) }
  it { is_expected.to have_many(:result_answers).dependent(:destroy) }

  describe '#before save' do
    let(:answer) { build :answer, content: 'Answer     1' }
    before { answer.save }
    it do
      expect(answer.content).to eq('Answer 1')
    end
  end
end
