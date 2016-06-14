class Project < ActiveRecord::Base
  belongs_to :student

  def capstone
    Project.all.where(capstone: true)
  end
end
