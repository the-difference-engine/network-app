class FollowUpList < ActiveRecord::Base
  belongs_to :employer
  has_and_belongs_to_many :students, dependent: :destroy

  validates :name, presence: true
end
