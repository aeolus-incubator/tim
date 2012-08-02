module ImageManagement
  class TargetImage < ActiveRecord::Base
    belongs_to :image_version
    has_many :provider_images

    before_save :create_factory_target_image

    attr_accessible :target, :image_version_id

    accepts_nested_attributes_for :image_version, :class_name => "ImageManagement::ImageVersion"

    def template
      image_version.base_image.template
    end

    private
    def create_factory_target_image
      begin
        target_image = ImageFactory::TargetImage.create(:template => template.xml,
                                                        :target => target)
        populate_factory_fields(target_image)
      rescue => e
        # TODO Add proper error handling
        raise e
      end
    end
  
    def populate_factory_fields(factory_target_image)
      self.status = factory_target_image.status
      self.factory_id = factory_target_image.id
      self.status_detail = factory_target_image.status_detail.activity
      self.progress = factory_target_image.percent_complete
    end
  end
end