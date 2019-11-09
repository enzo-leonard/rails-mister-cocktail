class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :mini do
    resize_to_fit 1080, 500
  end

  # Remove everything else
end
