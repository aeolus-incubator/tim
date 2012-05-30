module ImageManagement
  class TargetImage < ActiveRecord::Base
    belongs_to :image_version
    has_many :provider_images

    before_save :create_factory_target_image

    attr_accessible :target

    def template
      image_version.base_image.template
    end

    private
    def create_factory_target_image
      begin
        target_image = ImageFactory::TargetImage.create(:template => template.to_xml,
                                                        :target => target)
        populate_factory_fields(target_image)
      # TODO Add in proper exception handling
      rescue => e
        raise e
      end
    end
  
    def populate_factory_fields(factory_target_image)
      self.status = factory_target_image.status
      self.factory_id = factory_target_image.id
      self.status_detail = factory_target_image.status_detail
      self.progress = factory_target_image.percentage_complete
    end
  end
end
