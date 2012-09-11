require File.expand_path('../../app/models/image_management/base_image', ImageManagement::Engine.called_from)

class ImageManagement::BaseImage #.class_eval do
  belongs_to :pool_family
#  include ImageManagement::Concerns::Models::BaseImage
end

