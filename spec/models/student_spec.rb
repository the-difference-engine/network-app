require 'rails_helper'

RSpec.describe Student, :type => :model do
  it 'has a valid factory' do
    expect(build(:student)).to be_valid
  end

  it "returns an student's full name as a string" do
    student = build(:student, 
      first_name: "Kerry", 
      last_name: "Wood"
    )
    expect(student.full_name).to eq("Kerry Wood")
  end
end