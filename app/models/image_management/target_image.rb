module ImageManagement
  class TargetImage < ActiveRecord::Base
    belongs_to :image_version
    belongs_to :provider_type,
	       :class_name => ImageManagement.provider_type_class
    has_many :provider_images

    after_create :create_factory_target_image

    attr_accessible :target, :image_version_id

    accepts_nested_attributes_for :image_version

    def template
      image_version.base_image.template
    end

    private
    def create_factory_target_image
      begin
        target_image = ImageFactory::TargetImage.new(:template => template.xml,
                                                        :target => target,
                                                        :parameters => nil)
                                                        # A bug in ARes adds parameters twice to the resulting json
                                                        # when a map is provided in mass assign
        target_image.parameters =  { :callbacks => ["#{ImageFactory::TargetImage.callback_url}/#{self.id}"] }
        target_image.save!

        populate_factory_fields(target_image)
        self.save
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
