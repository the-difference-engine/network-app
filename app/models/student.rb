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

  validates :first_name, :last_name, :city, :grad_date, presence: true

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
end

