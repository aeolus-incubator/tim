require File.expand_path('../../app/models/image_management/provider_image', ImageManagement::Engine.called_from)

module ImageManagement
  class ProviderImage
    belongs_to :provider_account
  end
end