require 'rails_helper'

describe Admin do 
  it "is valid with a first name, last name, email, password" do
    expect(FactoryGirl.build(:admin)).to be_valid
  end

  it "in invalid without a first name"
  it "in invalid without a last name"
  it "returns an admin's full name as a string"
end