FactoryGirl.define do
  factory :base_image, :class => ImageManagement::BaseImage do
  end

  factory :base_image_with_template, :parent => :base_image do
    association :template, :factory => :template
  end
end