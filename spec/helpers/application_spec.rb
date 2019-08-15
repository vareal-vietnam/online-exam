require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    context 'page_title is nil' do
      subject { helper.full_title }

      it { is_expected.not_to include(' | ') }
    end

    context 'page_title is not nil' do
      let(:page_title) { 'Test' }
      subject { helper.full_title(page_title) }

      it { is_expected.to include(' | ') }
    end
  end
end
