class Project < ActiveRecord::Base
  mount_uploader :project_image, ProjectImageUploader
  
  belongs_to :student

  validates :name, :description, presence: true

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
    elsif normalized_screencast.include?("/embed/")
      normalized_screencast
    else 
      false
    end
  end
end
