require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to have_many(:result_answers).dependent(:destroy) }

  describe '#trim_space_content' do
    let(:answer) { build :answer, content: 'Answer     1' }
    before { answer.save }

    it { expect(answer.content).to eq('Answer 1') }
  end
end
