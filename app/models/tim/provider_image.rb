module Tim
  class ProviderImage < Tim::Base
    include FSM

    belongs_to :target_image, :inverse_of => :provider_images
    belongs_to :provider_account, :class_name => Tim.provider_account_class

    accepts_nested_attributes_for :target_image

    attr_accessible :target_image_attributes
    attr_accessible :external_image_id, :if => :imported?
    attr_accessible :status, :status_detail, :progress #, :as => :image_factory
    attr_accessible :provider
    attr_writer :credentials
    attr_protected :id

    validates_presence_of :target_image
    validates_presence_of :external_image_id, :if => :imported?

    after_create :create_factory_provider_image, :unless => :imported?
    after_create :create_import, :if => :imported?

    def imported?
      target_image.imported?
    end

    private
    def factory_provider_credentials
      @credentials
    end

    def factory_provider
      self.provider
    end

    def create_factory_provider_image
      begin
        provider_image = ImageFactory::ProviderImage.new(:credentials => factory_provider_credentials,
                                                          # TODO Remove this when upgrading to 3.2
                                                          # target conflicts with rails 3.0.10
                                                          # ActiveRecord::Associations::Association#target
                                                          :target => target_image.target,
                                                          :parameters => "")
        provider_image.provider = factory_provider
        # TODO There is a bug in ARes 3.0.10 that will add map name twice when setting in mass assign.  So we set
        # parameters separately.
        # Setting parameters at mass assign results in json => {"target_image":"parameters":{"parameters":{"..."}}}"
        # This should be tested and removed if fixed in 3.2
        provider_image.parameters = { :callbacks => ["#{ImageFactory::ProviderImage.callback_url}/#{self.id}"] }
        if target_image.snapshot?
          provider_image.parameters[:snapshot] = true
          provider_image.template = self.target_image.template.xml
        else
          provider_image.target_image_id = self.target_image.factory_id
        end

        provider_image.save!
        populate_factory_fields(provider_image)
        self.save
      rescue Errno::ECONNREFUSED
        raise Tim::Error::ImagefactoryConnectionRefused.new("Unable to connect"\
         " to Imagefactory server @ #{Tim::ImageFactory::Base.site}")
      rescue => e
        # TODO Add proper error handling
        raise e
      end
    end

    def populate_factory_fields(factory_provider_image)
      self.status = factory_provider_image.status
      self.factory_id = factory_provider_image.id
      self.status_detail = factory_provider_image.status_detail.activity
      self.progress = factory_provider_image.percent_complete
      self.provider = factory_provider_image.provider
      self.external_image_id = factory_provider_image.identifier_on_provider
      self.factory_provider_account_id = factory_provider_image.provider_account_identifier
    end

    # TODO At the moment this method simply sets fields to import defaults.
    # We should investigate whether we can check the image exists and if the
    # user can access it.  Deltacloud?
    def create_import
      self.status = "COMPLETE"
      self.progress = "COMPLETE"
      self.status_detail = "Imported Image"
      self.save
    end
  end
end
