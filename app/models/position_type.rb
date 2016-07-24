class PositionType < ActiveRecord::Base
  has_and_belongs_to_many :employers, dependent: :destroy
end
