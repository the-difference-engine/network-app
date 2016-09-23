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

  def screencast?
    if screencast != "" && screencast != nil 
      true
    else
      false
    end
  end

  def embed_youtube_screencast
    if normalized_screencast.include?("youtube") && normalized_screencast.include?("watch?v=") && !normalized_screencast.include?("&feature=")
      link = normalized_screencast
      link_for_embed = link.gsub!("watch?v=", "embed/")
    elsif normalized_screencast.include?("&feature=")
      match_index = /&feature=/ =~ normalized_screencast
      link_end_index = match_index - 1
      remove_feature_link = normalized_screencast[0..link_end_index]
      link = remove_feature_link
      link_for_embed = link.gsub!("watch?v=", "embed/")
    elsif normalized_screencast.include?("youtube") && normalized_screencast.include?("/embed/")
      normalized_screencast
    elsif normalized_screencast.include?("youtu.be/")
      split_sections = normalized_screencast.split("/")
      video_id = split_sections.last
      link_for_embed = "https://www.youtube.com/embed/#{video_id}"
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
