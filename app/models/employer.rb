class Employer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :capitalize_params
  after_create :create_list
  has_one :follow_up_list, dependent: :destroy

  def rep_full_name
    "#{rep_first_name} #{rep_last_name}"
  end

  def normalized_webpage
    website && PostRank::URI.normalize(website).to_s
  end

  def create_list
    FollowUpList.create(name: "#{self.name}-List", employer_id: self.id)
  end

  def capitalize_params
    self.description = self.description.capitalize
    self.rep_first_name = self.rep_first_name.downcase.titleize if self.rep_first_name
    self.rep_last_name = self.rep_last_name.downcase.titleize if self.rep_last_name
    self.city = self.city.downcase.titleize if self.city
    self.state = self.state.downcase.titleize if self.state
  end
  
end
