class Employer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :sign_up_code
  mount_uploader :image, ImageUploader

  # before_update :capitalize_params
  after_create :create_list
  has_one :follow_up_list, dependent: :destroy
  has_and_belongs_to_many :positions
  has_and_belongs_to_many :position_types
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :salary_ranges
  has_and_belongs_to_many :technologies
  has_many :employer_email_records, dependent: :destroy
  has_many :student_email_records, dependent: :destroy

  validates :name, :rep_first_name, :rep_last_name, :rep_email, presence: true
  validates :rep_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :city, :state, presence: true
  validates :description, presence: true
  validates :number_of_positions, numericality: { only_integer: true, allow_nil: true }
  validates :sign_up_code, on: :create, presence: true, inclusion: { in: [ ENV["sign_up_code_one"], ENV["sign_up_code_two"] ]}, allow_nil: true

  def rep_full_name
    "#{rep_first_name} #{rep_last_name}"
  end

  def normalized_website
    website && PostRank::URI.normalize(website).to_s
  end

  def create_list
    FollowUpList.create(name: "#{self.name}-List", employer_id: self.id)
  end

  def location
    "#{city}, #{state}"
  end

  def hiring_fields?
    fields = false

    if number_of_positions == nil || number_of_positions == ""
      number_of_positions_entered = false
    else
      number_of_positions_entered = true
    end

    if hiring_timeline == nil || hiring_timeline == ""
      hiring_timeline_entered = false
     else
      hiring_timeline_entered = true
    end

    if number_of_positions_entered || hiring_timeline_entered
      fields = true
    end

    fields
  end
end
