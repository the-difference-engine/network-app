require 'rails_helper'

RSpec.describe Admin, :type => :model do
  it 'has a valid factory' do
    expect(build(:admin)).to be_valid
  end

  it "is valid with a first name, last name, email, password" do
    expect(build(:admin)).to be_valid
  end

  it "is invalid without a first name" do
    admin = build(:invalid_admin)
    admin.valid?
    expect(admin.errors[:first_name]).to include("can't be blank")
  end

  context "with model methods" do
    it "returns an admin's full name as a string" do
      admin = build(:admin, 
        first_name: "Joe", 
        last_name: "Maddon"
      )
      expect(admin.full_name).to eq("Joe Maddon")
    end
  end
end