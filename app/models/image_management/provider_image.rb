module ImageManagement
  class ProviderImage < ActiveRecord::Base
    belongs_to :target_image
    belongs_to :provider_account,
	       :class_name => ImageManagement.provider_account_class

    after_create :create_factory_provider_image

    attr_writer :credentials

    attr_accessible :provider, :target_image_id

    accepts_nested_attributes_for :target_image

    def create_factory_provider_image
      begin
        provider_image = ImageFactory::ProviderImage.new(:target_image_id => self.target_image.factory_id,
                                                         :provider => self.provider,
                                                         :credentials => @credentials,
                                                          # TODO Remove this when upgrading to 3.2
                                                          # target conflicts with rails 3.0.10
                                                          # ActiveRecord::Associations::Association#target
                                                          :target => target_image.target.target,
                                                          :parameters => "")
        # TODO There is a bug in ARes 3.0.10 that will add map name twice when setting in mass assign.  So we set
        # parameters separately.
        # Setting parameters at mass assign results in json => {"target_image":"parameters":{"parameters":{"..."}}}"
        # This should be tested and removed if fixed in 3.2
        provider_image.parameters = { :callbacks => ["#{ImageFactory::ProviderImage.callback_url}/#{self.id}"] }
        provider_image.save!
        populate_factory_fields(provider_image)
        self.save
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
      self.provider_account_id = factory_provider_image.provider_account_identifier
    end
  end
end
