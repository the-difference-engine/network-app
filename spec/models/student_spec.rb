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

    it 'returns normalized student linked_in link as a string' do
      student = build(:student, 
        linked_in: "linkedin.com/in/jake-arrieta-2853944a")
      expect(student.normalized_linked_in).to eq("http://linkedin.com/in/jake-arrieta-2853944a")
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

    it 'returns true if student has at least one non-nil skill attribute ' do
      student = create(:student,
        skill_1: nil,
        skill_2: nil,
        skill_3: "pitching")
      expect(student.skills?).to eq(true)
    end

    it 'returns false if student has all nil skill attributes' do
      student = create(:student,
        skill_1: nil,
        skill_2: nil,
        skill_3: nil)
      expect(student.skills?).to eq(false)
    end

    it 'returns true if student has at least one non-empty-string skill attribute' do
      student = create(:student,
        skill_1: "",
        skill_2: "",
        skill_3: "pitching")
      expect(student.skills?).to eq(true)
    end

    it 'returns false if student has all empty-string skill attributes' do
      student = create(:student,
        skill_1: "",
        skill_2: "",
        skill_3: "")
      expect(student.skills?).to eq(false)
    end

    it 'returns true if student has at least one non-nil interview answer' do
      student = create(:student,
        interview_1: nil,
        interview_2: nil,
        interview_3: "if you look hot, wear it")
      expect(student.interview_answers?).to eq(true)
    end

    it 'returns false if student has all nil interview answers' do
      student = create(:student,
        interview_1: nil,
        interview_2: nil,
        interview_3: nil)
      expect(student.interview_answers?).to eq(false)
    end

    it 'returns true if student has at least one non-empty-string interview answer' do
      student = create(:student,
        interview_1: "",
        interview_2: "",
        interview_3: "if you look hot, wear it")
      expect(student.interview_answers?).to eq(true)
    end

    it 'returns false if student has all empty-string interview answers' do
      student = create(:student,
        interview_1: "",
        interview_2: "",
        interview_3: "")
      expect(student.interview_answers?).to eq(false)
    end

    it 'returns "abbreviated month year" format for student friendly_grad_date method' do
      student = create(:student,
        grad_date: "2016-03-25")
      expect(student.friendly_grad_date).to eq("Mar 2016")
    end
  end
end