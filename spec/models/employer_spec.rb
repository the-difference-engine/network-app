require 'rails_helper'

RSpec.describe Employer, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"  
  it 'has a valid factory' do
    expect(build(:employer)).to be_valid
  end

  it 'creates a follow-up-list' do
    employer = create(:employer, name: "Cubs")
    expect{ employer.create_list }.to change(FollowUpList, :count).by(1)
  end

  it 'creates a follow-up-list with name "employer_name-list"' do
    employer = create(:employer, name: "Cubs")
    expect(employer.follow_up_list.name).to eq("Cubs-List")
  end   
end

