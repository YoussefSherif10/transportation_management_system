require 'rails_helper'

RSpec.describe Truck, type: :model do
  it "has a valid factory" do
    expect(build(:truck)).to be_valid
  end

  it "is invalid without a name" do
    truck = build(:truck, name: nil)
    expect(truck).to_not be_valid
  end

  it "is invalid without a truck type" do
    truck = build(:truck, truck_type: nil)
    expect(truck).to_not be_valid
  end

  it "has many assignments" do
    should have_many(:assignments)
  end

  it "has many drivers through assignments" do
    should have_many(:drivers).through(:assignments)
  end
end