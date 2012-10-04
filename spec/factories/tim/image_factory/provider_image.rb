FactoryGirl.define do
  factory :image_factory_provider_image, :class => Tim::ImageFactory::ProviderImage do
    status "New"
    id "4cc3b024-5fe7-4b0b-934b-c5d463b990b0"
    percent_complete "10"
    provider "MockSphere"
    identifier_on_provider "mock-123456"
    provider_account_identifier "mock-account-123"
  end
end