class Technology < ActiveRecord::Base
  has_and_belongs_to_many :employers, dependent: :destroy
  has_and_belongs_to_many :students, dependent: :destroy
  has_and_belongs_to_many :projects, dependent: :destroy

  validates :name, presence: true
end
