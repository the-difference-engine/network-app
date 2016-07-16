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

  def interview_answers?
    unless interview_1 == nil || interview_1 == "" || interview_2 == nil || interview_2 == "" || interview_3 == nil || interview_3 == ""
      true
    else
      false
    end
  end


end

