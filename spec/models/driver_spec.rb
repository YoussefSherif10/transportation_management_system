require 'rails_helper'

RSpec.describe Driver, type: :model do
  it "has a valid factory" do
    expect(build(:driver)).to be_valid
  end

  it "is invalid without an email" do
    driver = build(:driver, email: nil)
    expect(driver).to_not be_valid
  end

  it "is invalid with a duplicate email" do
    create(:driver, email: "test@example.com")
    driver = build(:driver, email: "test@example.com")
    expect(driver).to_not be_valid
  end

  it "has many assignments" do
    should have_many(:assignments)
  end

  it "has many trucks through assignments" do
    should have_many(:trucks).through(:assignments)
  end
end
