FactoryGirl.define do
  factory :base_image, :class => ImageManagement::BaseImage do
    name "test base image"
    description "description of test image"
  end

  factory :base_image_with_template, :parent => :base_image do
    association :template, :factory => :template
  end
end