require 'rails_helper'

describe Admin do 
  it "is valid with a first name, last name, email, password" do
    expect(FactoryGirl.build(:admin)).to be_valid
  end

  it "in invalid without a first name" do
    admin = FactoryGirl.build(:admin, first_name: nil)
    admin.valid?
    expect(admin.errors[:first_name]).to include("can't be blank")
  end
  it "in invalid without a last name"
  it "returns an admin's full name as a string"
end