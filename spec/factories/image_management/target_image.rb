FactoryGirl.define do
  factory :target_image, :class => ImageManagement::TargetImage do
    association :image_version, :factory => :image_version
    target 'Mock'
  end
end