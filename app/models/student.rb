class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, UserFileUploader
  # mount_uploader :resume, UserFileUploader
  
  belongs_to :follow_up_list
  has_many :projects, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def capstone_project
    Project.all.find_by(:student_id => id, :capstone => true)
    # projects.where(capstone: true).last
  end

  def normalized_github
    github && PostRank::URI.normalize(github).to_s
  end

  def normalized_blog
    blog && PostRank::URI.normalize(blog).to_s
  end

  def processed_email
    return /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}\b/i.match(self)
  end
  
end

