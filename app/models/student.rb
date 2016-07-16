class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, UserFileUploader
  mount_uploader :resume, ResumeUploader
  
  belongs_to :follow_up_list
  has_many :projects, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def capstone_project
    Project.all.find_by(:student_id => id, :capstone => true)
  end

  def normalized_github
    github && PostRank::URI.normalize(github).to_s
  end

  def normalized_blog
    blog && PostRank::URI.normalize(blog).to_s
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
      grad_date.strftime("%b %Y")
    end
  end

  def skills?
    skills_answered = false

    if skill_1 == nil || skill_1 == ""
      skill_1 = false
    else
      skill_1 = true
    end

    if skill_2 == nil || skill_2 == ""
      skill_2 = false
     else
      skill_2 = true
    end

    if skill_3 == nil || skill_3 == ""
      skill_3 = false
    else
      skill_3 = true
    end

    if skill_1 || skill_2 || skill_3
      skills_answered = true
    end

    return skills_answered
  end

  def interview_answers?
    questions_answered = false

    if interview_1 == nil || interview_1 == ""
      question_1 = false
    else
      question_1 = true
    end

    if interview_2 == nil || interview_2 == ""
      question_2 = false
     else
      question_2 = true
    end

    if interview_3 == nil || interview_3 == ""
      question_3 = false
    else
      question_3 = true
    end

    if question_1 || question_2 || question_3
      questions_answered = true
    end

    return questions_answered
  end
end

