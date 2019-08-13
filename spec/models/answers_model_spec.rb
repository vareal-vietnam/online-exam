require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build :answer }

  it { is_expected.to belong_to(:question) }
  it { is_expected.to have_many(:result_answers).dependent(:destroy) }

  it '#before save' do
    answer.content = 'Answer    content'
    answer.run_callbacks :save
    expect(answer.content).to eq('Answer content')
  end
end
