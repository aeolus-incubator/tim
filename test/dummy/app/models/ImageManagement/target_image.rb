require File.expand_path('../../app/models/image_management/target_image', ImageManagement::Engine.called_from)

module ImageManagement
  class TargetImage
    belongs_to :provider_type
  end
end