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

    it 'returns all client projects if project client_work attribute = true' do
      student = create(:student)
      project_1 = create(:project, client_work: true, student: student)
      project_2 = create(:project, client_work: true, student: student)
      project_2 = create(:project, client_work: false, student: student)
      projects = student.client_projects
      expect(projects.count).to eq(2)
    end

    it 'returns only personal projects, excluding projects with client_work or capstone = true' do
      student = create(:student)
      project_1 = create(:project, client_work: true, student: student)
      project_2 = create(:project, capstone: true, student: student)
      project_2 = create(:project, capstone: false, client_work: false, student: student)
      projects = student.personal_projects
      expect(projects.count).to eq(1)
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

    it 'returns true if student has at least one non-nil interest answer' do
      student = create(:student,
        interest_1: nil,
        interest_2: nil,
        interest_3: "if you look hot, wear it")
      expect(student.interests?).to eq(true)
    end

    it 'returns false if student has all nil interest answers' do
      student = create(:student,
        interest_1: nil,
        interest_2: nil,
        interest_3: nil)
      expect(student.interests?).to eq(false)
    end

    it 'returns true if student has at least one non-empty-string interest answer' do
      student = create(:student,
        interest_1: "",
        interest_2: "",
        interest_3: "if you look hot, wear it")
      expect(student.interests?).to eq(true)
    end

    it 'returns false if student has all empty-string interest answers' do
      student = create(:student,
        interest_1: "",
        interest_2: "",
        interest_3: "")
      expect(student.interests?).to eq(false)
    end

    it 'returns "abbreviated month year" format for student friendly_grad_date method' do
      student = create(:student,
        grad_date: "2016-03-25")
      expect(student.friendly_grad_date).to eq("March 2016")
    end

    it 'returns true if student has at least one non-empty-string social link (github, blog, linked_in) answer' do
      student = create(:student,
        github: "",
        blog: "",
        linked_in: "if you look hot, wear it")
      expect(student.social_links?).to eq(true)
    end

    it 'returns false if student has all empty-string social link (github, blog, linked_in) answers' do
      student = create(:student,
        github: "",
        blog: "",
        linked_in: "")
      expect(student.social_links?).to eq(false)
    end

    it 'returns true if student has at least one non-nil social link (github, blog, linked_in) answer' do
      student = create(:student,
        github: nil,
        blog: nil,
        linked_in: "if you look hot, wear it")
      expect(student.social_links?).to eq(true)
    end

    it 'returns false if student has all nil social link (github, blog, linked_in) answers' do
      student = create(:student,
        github: nil,
        blog: nil,
        linked_in: nil)
      expect(student.social_links?).to eq(false)
    end
  end
end