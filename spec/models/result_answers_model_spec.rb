require 'rails_helper'

RSpec.describe ResultAnswer, type: :model do
  let(:result) { create :result }
  let(:result_answer) { create :result_answer, result: result }

  it { is_expected.to belong_to(:answer) }
  it { is_expected.to belong_to(:result) }

  it { is_expected.to validate_presence_of(:answer) }
  it { is_expected.to validate_presence_of(:result) }

  it 'Check scope' do
    expect(ResultAnswer.by_result(result_answer.result).count)
      .not_to be_zero
  end
end
