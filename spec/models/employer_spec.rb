require 'rails_helper'

RSpec.describe Employer, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"  
  it 'has a valid factory' do
    expect(build(:employer)).to be_valid
  end

  context "with model methods" do
    it 'creates a follow-up-list' do
      employer = create(:employer, name: "Cubs")
      expect{ employer.create_list }.to change(FollowUpList, :count).by(1)
    end

    it 'creates a follow-up-list with name "employer_name-list"' do
      employer = create(:employer, name: "Cubs")
      expect(employer.follow_up_list.name).to eq("Cubs-List")
    end

    it 'returns employer rep full name as a string' do
      employer = build(:employer, 
        rep_first_name: "Joe",
        rep_last_name: "Maddon")
      expect(employer.rep_full_name).to eq("Joe Maddon")
    end

    it 'returns normalized employer website as a string' do
      employer = build(:employer, 
        website: "cubs.com")
      expect(employer.normalized_website).to eq("http://cubs.com/")
    end
  end

  it 'capitalizes description, rep_first_name, rep_last_name, city parameters' do
    employer = create(:employer, 
      description: "baseball team",
      rep_first_name: "joe",
      rep_last_name: "maddon",
      city: "chicago")
    employer.capitalize_params
    expect(employer.description).to eq("Baseball team")
    expect(employer.rep_first_name).to eq("Joe")
    expect(employer.rep_last_name).to eq("Maddon")
    expect(employer.city).to eq("Chicago")
  end
end

