require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    context 'page_title is nil' do
      it { expect(helper.full_title).not_to include(' | ') }
    end

    context 'page_title is not nil' do
      let(:page_title) { 'Test' }

      it { expect(helper.full_title(page_title)).to include(' | ') }
    end
  end
end
