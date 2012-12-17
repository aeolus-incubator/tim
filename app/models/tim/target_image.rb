module Tim
  class TargetImage < Tim::Base
    belongs_to :image_version, :inverse_of => :target_images
    has_many :provider_images, :inverse_of => :target_image

    belongs_to :provider_type, :class_name => Tim.provider_type_class

    accepts_nested_attributes_for :image_version
    accepts_nested_attributes_for :provider_images

    validates_presence_of :image_version, :target

    attr_accessible :image_version_attributes
    attr_accessible :provider_images_attributes
    attr_accessible :status, :status_detail, :progress #, :as => :image_factory
    attr_accessible :target

    attr_protected :id

    after_create :create_factory_target_image, :if => :create_factory_target_image?
    after_create :create_import, :if => :imported?

    def template
      image_version.base_image.template
    end

    def imported?
      image_version.base_image.import
    end

    def snapshot?
      build_method == "SNAPSHOT"
    end

    private
    def create_factory_target_image
      begin
        target_image = ImageFactory::TargetImage.new(:target => target,
                                                     :parameters => nil)
        # A bug in ARes adds parameters twice to the resulting json when a map
        # is provided in mass assign
        target_image.parameters =  { :callbacks => ["#{ImageFactory::TargetImage.callback_url}/#{self.id}"] }

        if image_version.factory_base_image_id
          target_image.base_image_id = image_version.factory_base_image_id
        else
          target_image.template = template.xml
        end
        target_image.save!

        populate_factory_fields(target_image)
        self.save
      rescue Errno::ECONNREFUSED
        raise Tim::Error::ImagefactoryConnectionRefused.new("Unable to connect"\
         " to Imagefactory server @ #{Tim::ImageFactory::Base.site}")
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
      unless self.image_version.factory_base_image_id
        image_version.factory_base_image_id = factory_target_image.base_image_id
        image_version.save!
      end
    end

    def create_import
      self.progress = "COMPLETE"
      self.status = "IMPORTED"
      self.status_detail = "Imported Image"
      self.save
    end

    private 
    def create_factory_target_image?
      !imported? && !snapshot?
    end
  end
end
