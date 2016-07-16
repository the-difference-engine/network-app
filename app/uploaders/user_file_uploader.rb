# encoding: utf-8

class UserFileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # version :large do
  #   process resize_to_limit: [800,800]
  # end

  version :large do
    process resize_to_limit: [1000,1000]
  end

  # version :medium_square do
  #   process resize_to_fill: [500,500]
  # end

  # version :standard, :from_version => :medium do
  #   process resize_to_limit: [300,300]
  # end

  # version :standard_square, :from_version => :medium do
  #   process resize_to_fill: [300,300]
  # end

  version :show_tall, :from_version => :large do
    process resize_to_limit: [300,400]
  end

  version :show_tall_crop do
    process resize_to_fill: [300,400]
  end

  version :index_square_lg, :from_version => :large do
    process resize_to_fill: [358,358]
  end

  version :index_square, :from_version => :large do
    process resize_to_fill: [300,300]
  end

  version :thumb, :from_version => :large do
    process resize_to_fill: [100,100]
  end



  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    'no_avatar_1000.png'
  end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
