require 'rails_helper'

RSpec.describe TestsHelper, type: :helper do
  describe '#choise_kind_exam' do
    it { expect(helper.choise_kind_exam).to be_array }
  end
end
