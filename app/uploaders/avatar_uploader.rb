# class AvatarUploader < CarrierWave::Uploader::Base

#   include CarrierWave::RMagick

#   storage :fog

#   def fog_public
#     false
#   end

#   def fog_authenticated_url_expiration
#     1.minutes # in seconds from now,  (default is 10.minutes)
#   end

#   # Override the directory where uploaded files will be stored.
#   # This is a sensible default for uploaders that are meant to be mounted:
#   def store_dir
#     model.avatar
#   end

#   def filename
#     "#{secure_token}.#{file.extension}" if original_filename
#   end

#   # Create different versions of your uploaded files:
#   version :thumb do
#     process resize_to_fit: [200, 200]
#   end

#   version :profile do
#     process resize_to_limit: [400, 400]
#   end

#   def default_url
#     ActionController::Base.helpers.asset_path(["avatar-placeholder.png"].compact.join('_'))
#   end

#   protected
#     def secure_token
#       var = :"@#{mounted_as}_secure_token"
#       model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(6))
#     end

# end
