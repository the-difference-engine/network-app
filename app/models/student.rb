class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :follow_up_list
  has_many :projects, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def capstone_project
    Project.all.find_by(:student_id => id, :capstone => true)
    # projects.where(capstone: true).last
  end

 

end

