class Employer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_one :follow_up_list, dependent: :destroy

  def rep_full_name
    "#{rep_first_name} #{rep_last_name}"
  end

  def normalized_webpage
    website && PostRank::URI.normalize(website).to_s
  end
  
end
