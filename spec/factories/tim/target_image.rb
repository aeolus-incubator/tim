FactoryGirl.define do
  factory :target_image, :class => Tim::TargetImage do
    target 'Mock'
    build_method 'BARE_METAL'
  end

  factory :target_image_with_full_tree, :parent => :target_image do
    association :image_version, :factory => :image_version_with_full_tree
  end

  factory :target_image_import, :parent => :target_image do
    association :image_version, :factory => :image_version_import
  end
end