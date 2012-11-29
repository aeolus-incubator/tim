FactoryGirl.define do
  factory :provider_image, :class => Tim::ProviderImage do
  end

  factory :provider_image_with_full_tree, :parent => :provider_image do
    association :target_image, :factory => :target_image_with_full_tree
  end

  factory :provider_image_import, :parent => :provider_image do
    association :target_image, :factory => :target_image_import
  end
end
