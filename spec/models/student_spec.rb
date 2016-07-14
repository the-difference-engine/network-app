require 'rails_helper'

RSpec.describe Student, :type => :model do
  it 'has a valid factory' do
    expect(build(:student)).to be_valid
  end

  context "with model methods" do
    it "returns a student's full name as a string" do
      student = build(:student, 
        first_name: "Jake", 
        last_name: "Arrieta"
      )
      expect(student.full_name).to eq("Jake Arrieta")
    end

    it 'returns normalized student github link as a string' do
      student = build(:student, 
        github: "m.cubs.mlb.com/player/453562/jake-arrieta")
      expect(student.normalized_github).to eq("http://m.cubs.mlb.com/player/453562/jake-arrieta")
    end

    it 'returns normalized student blog link as a string' do
      student = build(:student, 
        blog: "m.cubs.mlb.com/player/453562/jake-arrieta")
      expect(student.normalized_blog).to eq("http://m.cubs.mlb.com/player/453562/jake-arrieta")
    end

    it 'returns "Yes" if seeking_employment attribute = true' do
      student = build(:student, 
        seeking_employment: true)
      expect(student.job_response).to eq("Yes")
    end

    it 'returns "No" if seeking_employment attribute = false' do
      student = build(:student, 
        seeking_employment: false)
      expect(student.job_response).to eq("No")
    end

    it 'returns capstone project if project capstone attribute = true' do
      student = create(:student)
      project = create(:project, student: student)
      expect(student.capstone_project).to eq(project)
    end
  end
end