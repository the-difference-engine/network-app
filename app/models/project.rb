class Project < ActiveRecord::Base
  mount_uploader :project_image, ProjectImageUploader
  
  belongs_to :student
  has_and_belongs_to_many :technologies

  validates :name, :description, :technologies, presence: true

  def normalized_github
    github && PostRank::URI.normalize(github).to_s
  end

  def normalized_website
    website && PostRank::URI.normalize(website).to_s
  end

  def normalized_screencast
    screencast && PostRank::URI.normalize(screencast).to_s
  end

  def project_type
    if capstone
      "Capstone Project"
    elsif client_work
      "Client Work"
    else
      "Personal Project"
    end
  end

  def embed_youtube_screencast
    if normalized_screencast.include?("youtube") && normalized_screencast.include?("watch?v=")
      link = normalized_screencast
      link_for_embed = link.gsub!("watch?v=", "embed/")
    elsif normalized_screencast.include?("youtube") && normalized_screencast.include?("/embed/")
      normalized_screencast
    else 
      false
    end
  end

  def project_links?
    project_links = false

    if github == nil || github == ""
      github_entered = false
    else
      github_entered = true
    end

    if website == nil || website == ""
      website_entered = false
     else
      website_entered = true
    end

    if screencast == nil || screencast == ""
      screencast_entered = false
    else
      screencast_entered = true
    end

    if github_entered || website_entered || screencast_entered
      project_links = true
    end

    project_links
  end
end
