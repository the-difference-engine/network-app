class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseInvitable::Inviter

  mount_uploader :avatar, AvatarUploader
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end