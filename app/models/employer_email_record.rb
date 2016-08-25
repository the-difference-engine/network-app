class EmployerEmailRecord < ActiveRecord::Base
  belongs_to :employer
  belongs_to :student
end
