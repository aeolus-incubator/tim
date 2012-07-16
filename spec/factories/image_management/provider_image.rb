FactoryGirl.define do
  factory :provider_image, :class => ImageManagement::ProviderImage do
    association :target_image, :factory => :target_image
  end

  factory :provider_image_with_full_tree, :parent => :provider_image do
    association :target_image, :factory => :target_image_with_full_tree
  end
end