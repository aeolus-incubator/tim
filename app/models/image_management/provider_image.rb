module ImageManagement
  class ProviderImage < ActiveRecord::Base
    belongs_to :target_image

    # TODO Should this be before create (Do we require retries)
    after_create :create_factory_provider_image

    accepts_nested_attributes_for :target_image, :class_name => "ImageManagement::TargetImage"

    def create_factory_provider_image
      # TODO during image factory integration
    end
  end
end