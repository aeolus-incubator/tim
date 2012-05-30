FactoryGirl.define do
  factory :base_image, :class => ImageManagement::BaseImage do
    association :template, :factory => :template
  end
end