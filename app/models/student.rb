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

# Does this need to be first?  Is there another way?

  def capstone_project
    projects.each do |project|
      if project.capstone
        return "true"
      else
        return "false"
      end
    end
  end

end

