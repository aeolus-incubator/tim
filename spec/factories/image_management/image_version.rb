module ImageManagement
  FactoryGirl.define do
    factory :image_version, :class => ImageManagement::ImageVersion do
    end

    factory :image_version_with_base_image, :parent => :image_version do
      association :base_image, :factory => :base_image
    end

    factory :image_version_with_full_tree, :parent => :image_version do
      association :base_image, :factory => :base_image_with_template
    end
  end
end