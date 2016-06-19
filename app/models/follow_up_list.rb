class FollowUpList < ActiveRecord::Base
  belongs_to :employer
  has_many :students
end
