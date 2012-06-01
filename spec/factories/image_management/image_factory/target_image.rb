FactoryGirl.define do
  factory :image_factory_target_image, :class => ImageManagement::ImageFactory::TargetImage do
    status 'BUILDING'
    factory_id '1234567890'
    status_detail ''
    percentage_complete '0'
  end
end