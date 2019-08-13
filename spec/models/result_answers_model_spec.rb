require 'rails_helper'

RSpec.describe ResultAnswer, type: :model do
  let(:result) { create :result }
  let(:result_answer) { create :result_answer, result: result }

  describe 'Check scope' do
    it do
      expect(ResultAnswer.by_result(result_answer.result).count)
        .not_to be_zero
    end
  end

  describe 'Check belong_to' do
    context '#belong_to answer' do
      it { is_expected.to belong_to(:answer) }
    end

    context '#belong_to result' do
      it { is_expected.to belong_to(:result) }
    end
  end

  describe 'Check validate' do
    context '#Validate answer' do
      it { is_expected.to validate_presence_of(:answer) }
    end

    context '#Validate result' do
      it { is_expected.to validate_presence_of(:result) }
    end
  end
end
