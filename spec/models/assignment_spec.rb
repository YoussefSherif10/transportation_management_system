require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it "has a valid factory" do
    expect(build(:assignment)).to be_valid
  end

  it "belongs to a driver" do
    should belong_to(:driver)
  end

  it "belongs to a truck" do
    should belong_to(:truck)
  end
end