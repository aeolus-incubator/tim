FactoryGirl.define do
  factory :image_factory_target_image, :class => Tim::ImageFactory::TargetImage do
    status "NEW"
    id '4cc3b024-5fe7-4b0b-934b-c5d463b990b0'
    percent_complete '0'
    base_image_id '2cc3b024-5fe7-4b0b-934b-c5d463b990b0'
  end
end