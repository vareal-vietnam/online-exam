require "rails_helper"

RSpec.describe User, :type => :model do
  it "has none to begin with" do
    expect(Widget.count).to eq 0
  end
end
