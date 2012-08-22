module ImageManagement
  class ProviderImage < ActiveRecord::Base
    belongs_to :target_image

    # TODO Should this be before create (Do we require retries)
    before_create :create_factory_provider_image

    attr_writer :credentials
    accepts_nested_attributes_for :target_image, :class_name => "ImageManagement::TargetImage"

    def create_factory_provider_image
      begin
        provider_image = ImageFactory::ProviderImage.create(:target_image_id => self.target_image.factory_id,
                                                            :provider => self.provider,
                                                            :credentials => @credentials,
                                                            # TODO Remove this when upgrading to 3.2
                                                            # target conflicts with rails 3.0.10
                                                            # ActiveRecord::Associations::Association#target
                                                            :target => target_image.target.target)
        populate_factory_fields(provider_image)
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
