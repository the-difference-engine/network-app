class FollowUpStudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :follow_up_list
end
