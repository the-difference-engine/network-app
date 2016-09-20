class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  mount_uploader :resume, ResumeUploader
  
  has_many :projects, dependent: :destroy
  has_and_belongs_to_many :technologies
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :positions
  has_many :follow_up_students
  has_many :follow_up_lists, through: :follow_up_students
  has_many :employer_email_records, dependent: :destroy
  has_many :student_email_records, dependent: :destroy

  validates :first_name, :last_name, :city, :grad_date, :skill_1, :skill_2, :skill_3, :technologies, :positions, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_location
    if current_city == nil || current_city == ""
      ""
    else
      unless current_state == nil || current_state == ""
        "#{current_city}, #{current_state}"
      end
    end
  end

  def capstone_project
    Project.all.find_by(:student_id => id, :capstone => true)
  end

  def client_projects
    Project.all.where(:student_id => id, :client_work => true)
  end

  def personal_projects
    Project.all.where(:student_id => id, :capstone => false, :client_work => false)
  end

  def normalized_github
    github && PostRank::URI.normalize(github).to_s
  end

  def normalized_blog
    blog && PostRank::URI.normalize(blog).to_s
  end

  def normalized_personal_website
    personal_website && PostRank::URI.normalize(personal_website).to_s
  end

  def normalized_linked_in
    linked_in && PostRank::URI.normalize(linked_in).to_s
  end

  def job_response
    if seeking_employment 
      "Yes"
    else 
      "No"
    end
  end

  def friendly_grad_date
    if grad_date
      grad_date.strftime("%B %Y")
    end
  end

  def skills?
    skills_answered = false

    if skill_1 == nil || skill_1 == ""
      skill_1_entered = false
    else
      skill_1_entered = true
    end

    if skill_2 == nil || skill_2 == ""
      skill_2_entered = false
     else
      skill_2_entered = true
    end

    if skill_3 == nil || skill_3 == ""
      skill_3_entered = false
    else
      skill_3_entered = true
    end

    if skill_1_entered || skill_2_entered || skill_3_entered
      skills_answered = true
    end

    return skills_answered
  end

  def interview_answers?
    questions_answered = false

    if interview_1 == nil || interview_1 == ""
      question_1_entered = false
    else
      question_1_entered = true
    end

    if interview_2 == nil || interview_2 == ""
      question_2_entered = false
     else
      question_2_entered = true
    end

    if interview_3 == nil || interview_3 == ""
      question_3_entered = false
    else
      question_3_entered = true
    end

    if question_1_entered || question_2_entered || question_3_entered
      questions_answered = true
    end

    return questions_answered
  end

  def interview_questions?
    questions_entered = false

    if interview_q1 == nil || interview_q1 == ""
      question_1_entered = false
    else
      question_1_entered = true
    end

    if interview_q2 == nil || interview_q2 == ""
      question_2_entered = false
     else
      question_2_entered = true
    end

    if interview_q3 == nil || interview_q3 == ""
      question_3_entered = false
    else
      question_3_entered = true
    end

    if question_1_entered || question_2_entered || question_3_entered
      questions_entered = true
    end

    return questions_entered
  end

  def interests?
    interests_answered = false

    if interest_1 == nil || interest_1 == ""
      interest_1_entered = false
    else
      interest_1_entered = true
    end

    if interest_2 == nil || interest_2 == ""
      interest_2_entered = false
     else
      interest_2_entered = true
    end

    if interest_3 == nil || interest_3 == ""
      interest_3_entered = false
    else
      interest_3_entered = true
    end

    if interest_1_entered || interest_2_entered || interest_3_entered
      interests_answered = true
    end

    return interests_answered
  end

  def social_links?
    social_links = false

    if github == nil || github == ""
      github_entered = false
    else
      github_entered = true
    end

    if blog == nil || blog == ""
      blog_entered = false
     else
      blog_entered = true
    end

    if linked_in == nil || linked_in == ""
      linked_in_entered = false
    else
      linked_in_entered = true
    end

    if personal_website == nil || personal_website == ""
      personal_website_entered = false
    else
      personal_website_entered = true
    end

    if github_entered || blog_entered || linked_in_entered || personal_website_entered
      social_links = true
    end

    social_links
  end

  def about_me?
    if about_me == nil || about_me == ""
      false
    else
      true
    end
  end

  def uploaded_avatar?
    if avatar.url.include?("aws")
      true
    else
      false
    end
  end

  def uploaded_resume?
    if resume.url && resume.url.include?("aws")
      true
    else
      false
    end
  end

  def reminder_modal
    if skills? && about_me? && uploaded_avatar? && uploaded_resume? && technologies.any? && positions.any?
      false
    else
      true
    end
  end

  def standout_score
    fields = [:email, :first_name, :last_name, :avatar, :city, :current_industry, :grad_date, :skill_1, :skill_2, :skill_3, :interest_1, :interest_2, :interest_3, :interview_1, :interview_2, :interview_3, :github, :blog, :quote, :seeking_employment, :resume, :linked_in, :current_city, :current_state, :about_me, :interview_q1, :interview_q2, :interview_q3, :personal_website]
    field_total = fields.count + 2 # has a capstone project + capstone screencast
    fields_completed = 0

    fields.each do |field|
      if self[field] != "" && self[field] != nil 
        fields_completed += 1
      end
    end

    if capstone_project
      fields_completed += 1

      if capstone_project.screencast?
        fields_completed += 1
      end
    end
    fields_completed.to_f / field_total * 100
  end

  def missing_student_fields
    fields = { 
      email: "Email Address", 
      first_name: "First Name", 
      last_name: "Last Name", 
      avatar: "Avatar", 
      city: "City (Actualize Bootcamp Location)", 
      current_industry: "Current Industry", 
      grad_date: "Graduation Date", 
      skill_1: "Top Skill One", 
      skill_2: "Top Skill Two" , 
      skill_3: "Top Skill Three", 
      interest_1: "Interest One", 
      interest_2: "Interest Two", 
      interest_3: "Interest Three", 
      interview_1: "Interview Question One Response", 
      interview_2: "Interview Question Two Response", 
      interview_3: "Interview Question Three Response", 
      github: "GitHub Link", 
      blog: "Personal Blog Link", 
      quote: "Personal Quote", 
      resume: "Resume On File", 
      linked_in: "LinkedIn Profile Link", 
      current_city: "Current City (City of Residence)", 
      current_state: "Current State (State of Residence)", 
      about_me: "About Me",
      interview_q1: "Interview Question One", 
      interview_q2: "Interview Question Two", 
      interview_q3: "Interview Question Three", 
      personal_website: "Personal Website Link"
    }
    
    missing_fields = []
    
    fields.each do |field_key, field_value|
      unless self[field_key] != "" && self[field_key] != nil
        missing_fields << field_value
      end
    end

    unless capstone_project
      missing_fields << "Capstone Project"
      missing_fields << "Capstone Project Screencast Video"
    end

    if capstone_project 
      unless capstone_project.screencast?
        missing_fields << "Capstone Project Screencast Video"
      end
    end
    missing_fields
  end

  def self.sort_by_standout_score
    Student.all.sort_by(&:standout_score)
  end
end

