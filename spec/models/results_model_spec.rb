require 'rails_helper'

RSpec.describe Result, type: :model do
  describe 'Check association' do
    context '#belong_to user' do
      it { is_expected.to belong_to(:user) }
    end

    context '#belong_to test' do
      it { is_expected.to belong_to(:test) }
    end

    context '#has_many result_answers' do
      it do
        is_expected.to have_many(:result_answers)
          .dependent(:destroy)
      end
    end
  end

  describe 'Check validate' do
    context 'Validate user' do
      it { is_expected.to validate_presence_of(:user) }
    end

    context 'Validate test' do
      it { is_expected.to validate_presence_of(:test) }
    end
  end
end
