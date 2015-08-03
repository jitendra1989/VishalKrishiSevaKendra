# encoding: utf-8

class BannerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  def store_dir
    "uploads/#{Rails.env}/#{model.class.to_s.underscore.pluralize}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads/#{Rails.env}/#{model.class.to_s.underscore.pluralize}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process resize_to_fill: [990, -1]

  # Create different versions of your uploaded files:
  version :medium do
    process resize_to_fill: [600, -1]
  end

  version :small, from_version: :medium do
    process resize_to_fill: [230, -1]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end

end
