class StudentEmailRecord < ActiveRecord::Base
  belongs_to :student
  belongs_to :employer
end
