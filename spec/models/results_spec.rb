require 'rails_helper'

RSpec.describe Result, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:test) }
  it do
    is_expected.to have_many(:result_answers)
      .dependent(:destroy)
  end

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:test) }
end
