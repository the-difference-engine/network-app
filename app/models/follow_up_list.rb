class FollowUpList < ActiveRecord::Base
  belongs_to :employer
  has_many :follow_up_students, dependent: :destroy
  has_many :students, through: :follow_up_students
  
  validates :name, presence: true
end
